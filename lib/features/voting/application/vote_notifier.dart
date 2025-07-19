import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agnonymous_app/features/voting/domain/post_vote_state.dart';

// In a real app, you would have a provider for your Supabase client
final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

// Using .family to create a unique notifier for each post
final voteNotifierProvider =
    NotifierProvider.family<VoteNotifier, PostVoteState, String>(
  VoteNotifier.new,
);

class VoteNotifier extends FamilyNotifier<PostVoteState, String> {
  // The post ID is the family parameter, available via `arg`
  String get postId => arg;

  @override
  PostVoteState build(String arg) {
    _fetchInitialVoteState();
    return const PostVoteState(truthfulVotes: 0, deceptiveVotes: 0);
  }

  Future<void> _fetchInitialVoteState() async {
    final supabase = ref.read(supabaseClientProvider);
    final userId = supabase.auth.currentUser?.id;

    // Fetch vote stats
    final List<dynamic> stats = await supabase.rpc(
      'get_post_vote_stats',
      params: {'post_id_in': postId},
    );

    int truthful = 0;
    int deceptive = 0;

    if (stats.isNotEmpty) {
      truthful = stats[0]['true_votes'] ?? 0;
      deceptive = stats[0]['false_votes'] ?? 0;
    }

    // Fetch current user's vote
    VoteType? currentUserVote;
    if (userId != null) {
      final List<dynamic> userVote = await supabase
          .from('truth_votes')
          .select('vote_type')
          .eq('post_id', postId)
          .eq('anonymous_user_id', userId)
          .limit(1);

      if (userVote.isNotEmpty) {
        final voteType = userVote[0]['vote_type'];
        if (voteType == 'true') {
          currentUserVote = VoteType.truthful;
        } else if (voteType == 'false') {
          currentUserVote = VoteType.deceptive;
        }
      }
    }

    state = state.copyWith(
      truthfulVotes: truthful,
      deceptiveVotes: deceptive,
      currentUserVote: currentUserVote,
    );
  }

  Future<void> castVote(VoteType vote) async {
    final supabase = ref.read(supabaseClientProvider);
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return; // Or handle not-logged-in case

    final originalState = state;
    final previousVote = state.currentUserVote;

    // 1. OPTIMISTIC UI UPDATE
    int newTruthfulVotes = state.truthfulVotes;
    int newDeceptiveVotes = state.deceptiveVotes;
    VoteType? newCurrentUserVote;

    // Determine the new vote state
    if (previousVote == vote) {
      // User is un-voting
      newCurrentUserVote = null;
      if (vote == VoteType.truthful) newTruthfulVotes--;
      if (vote == VoteType.deceptive) newDeceptiveVotes--;
    } else {
      // User is changing vote or casting a new vote
      newCurrentUserVote = vote;
      if (previousVote == VoteType.truthful) newTruthfulVotes--;
      if (previousVote == VoteType.deceptive) newDeceptiveVotes--;
      if (vote == VoteType.truthful) newTruthfulVotes++;
      if (vote == VoteType.deceptive) newDeceptiveVotes++;
    }

    // Instantly update the state with the new values
    state = state.copyWith(
      truthfulVotes: newTruthfulVotes,
      deceptiveVotes: newDeceptiveVotes,
      currentUserVote: newCurrentUserVote,
    );

    // 2. BACKGROUND NETWORK REQUEST
    try {
      await supabase.rpc(
        'cast_user_vote',
        params: {
          'post_id_in': postId,
          'user_id_in': userId,
          'vote_type_in': newCurrentUserVote?.name, // Pass null to remove vote
        },
      );
    } catch (e) {
      // 3. REVERT ON FAILURE
      state = originalState;
      // TODO: Inform the user that the action failed (e.g., show a snackbar).
    }
  }
}