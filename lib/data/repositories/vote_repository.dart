import 'package:agnonymous_app/data/datasources/supabase_datasource.dart';

class VoteRepository {
  final SupabaseDatasource _datasource;

  VoteRepository(this._datasource);

  Future<void> castUserVote(String postId, String userId, String? voteType) async {
    await _datasource.callRpc(
      'cast_user_vote',
      {
        'post_id_in': postId,
        'user_id_in': userId,
        'vote_type_in': voteType,
      },
    );
  }
}