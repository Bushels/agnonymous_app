import 'package:agnonymous_app/core/models/vote_stats_model.dart';
import 'package:agnonymous_app/data/datasources/supabase_datasource.dart';

class VoteRepository {
  final SupabaseDatasource _datasource;

  VoteRepository(this._datasource);

  Future<void> upvotePost(String postId, String userId) async {
    // Logic to record an upvote
    await _datasource.insertData('votes', {
      'post_id': postId,
      'user_id': userId,
      'vote_type': 'up',
    });
  }

  Future<void> downvotePost(String postId, String userId) async {
    // Logic to record a downvote
    await _datasource.insertData('votes', {
      'post_id': postId,
      'user_id': userId,
      'vote_type': 'down',
    });
  }

  Future<VoteStatsModel> getVoteStatsForPost(String postId) async {
    // This is a simplified example. In a real app, you might have a Supabase function
    // or a more complex query to aggregate vote counts.
    final List<Map<String, dynamic>> upvotes = await _datasource.fetchData(
      'votes',
      query: {'post_id': postId, 'vote_type': 'up'},
    );
    final List<Map<String, dynamic>> downvotes = await _datasource.fetchData(
      'votes',
      query: {'post_id': postId, 'vote_type': 'down'},
    );

    return VoteStatsModel(
      postId: postId,
      upvotes: upvotes.length,
      downvotes: downvotes.length,
    );
  }
}