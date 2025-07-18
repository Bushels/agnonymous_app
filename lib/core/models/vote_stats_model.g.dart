// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteStatsModelImpl _$$VoteStatsModelImplFromJson(Map<String, dynamic> json) =>
    _$VoteStatsModelImpl(
      postId: json['postId'] as String,
      upvotes: (json['upvotes'] as num).toInt(),
      downvotes: (json['downvotes'] as num).toInt(),
    );

Map<String, dynamic> _$$VoteStatsModelImplToJson(
        _$VoteStatsModelImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
    };
