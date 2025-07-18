import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class Post with _$Post {
  const Post._();
  
  const factory Post({
    required String id,
    required String anonymousUserId,
    String? title,
    required String content,
    required String category,
    String? subcategory,
    String? location,
    @Default([]) List<String> topics,
    @Default([]) List<String> evidenceUrls,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(0) int flagCount,
    @Default(false) bool isHidden,
    @Default(0) int commentCount,
  }) = _Post;
  
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  
  String get timeAgo => timeago.format(createdAt);
}