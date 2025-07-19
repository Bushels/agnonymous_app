import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_vote_state.freezed.dart';

enum VoteType { truthful, deceptive }

@freezed
class PostVoteState with _$PostVoteState {
  const factory PostVoteState({
    required int truthfulVotes,
    required int deceptiveVotes,
    VoteType? currentUserVote,
  }) = _PostVoteState;
}