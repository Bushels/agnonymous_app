import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/features/voting/application/vote_notifier.dart';
import 'package:agnonymous_app/features/voting/domain/post_vote_state.dart';

class TruthMeterWidget extends ConsumerWidget {
  final String postId;

  const TruthMeterWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the state for this specific post
    final voteState = ref.watch(voteNotifierProvider(postId));
    // Get the notifier to call the castVote method
    final voteNotifier = ref.read(voteNotifierProvider(postId).notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _VoteButton(
          label: 'Truthful',
          count: voteState.truthfulVotes,
          isSelected: voteState.currentUserVote == VoteType.truthful,
          onTap: () => voteNotifier.castVote(VoteType.truthful),
          color: Colors.green,
        ),
        const SizedBox(width: 16),
        _VoteButton(
          label: 'Deceptive',
          count: voteState.deceptiveVotes,
          isSelected: voteState.currentUserVote == VoteType.deceptive,
          onTap: () => voteNotifier.castVote(VoteType.deceptive),
          color: Colors.red,
        ),
      ],
    );
  }
}

class _VoteButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _VoteButton({ required this.label, required this.count, required this.isSelected, required this.onTap, required this.color });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(isSelected ? Icons.check_circle : Icons.radio_button_unchecked, color: isSelected ? color : Colors.grey),
      label: Text('$label ($count)'),
      style: OutlinedButton.styleFrom(
        foregroundColor: isSelected ? color : Colors.grey[700],
        side: BorderSide(color: isSelected ? color : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }
}