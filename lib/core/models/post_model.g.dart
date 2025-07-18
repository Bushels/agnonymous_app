// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      anonymousUserId: json['anonymousUserId'] as String,
      title: json['title'] as String?,
      content: json['content'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      location: json['location'] as String?,
      topics: (json['topics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      evidenceUrls: (json['evidenceUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      flagCount: (json['flagCount'] as num?)?.toInt() ?? 0,
      isHidden: json['isHidden'] as bool? ?? false,
      commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'anonymousUserId': instance.anonymousUserId,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'location': instance.location,
      'topics': instance.topics,
      'evidenceUrls': instance.evidenceUrls,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'flagCount': instance.flagCount,
      'isHidden': instance.isHidden,
      'commentCount': instance.commentCount,
    };
