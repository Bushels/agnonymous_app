import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_stats_model.freezed.dart';
part 'vote_stats_model.g.dart';

@freezed
class VoteStatsModel with _$VoteStatsModel {
  const factory VoteStatsModel({
    required String postId,
    required int upvotes,
    required int downvotes,
  }) = _VoteStatsModel;

  factory VoteStatsModel.fromJson(Map<String, dynamic> json) => _$VoteStatsModelFromJson(json);
}