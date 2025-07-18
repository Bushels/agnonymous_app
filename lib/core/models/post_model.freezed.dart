// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String get id => throw _privateConstructorUsedError;
  String get anonymousUserId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String> get topics => throw _privateConstructorUsedError;
  List<String> get evidenceUrls => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int get flagCount => throw _privateConstructorUsedError;
  bool get isHidden => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String id,
      String anonymousUserId,
      String? title,
      String content,
      String category,
      String? subcategory,
      String? location,
      List<String> topics,
      List<String> evidenceUrls,
      DateTime createdAt,
      DateTime? updatedAt,
      int flagCount,
      bool isHidden,
      int commentCount});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? anonymousUserId = null,
    Object? title = freezed,
    Object? content = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? location = freezed,
    Object? topics = null,
    Object? evidenceUrls = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? flagCount = null,
    Object? isHidden = null,
    Object? commentCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      anonymousUserId: null == anonymousUserId
          ? _value.anonymousUserId
          : anonymousUserId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      topics: null == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evidenceUrls: null == evidenceUrls
          ? _value.evidenceUrls
          : evidenceUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      flagCount: null == flagCount
          ? _value.flagCount
          : flagCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String anonymousUserId,
      String? title,
      String content,
      String category,
      String? subcategory,
      String? location,
      List<String> topics,
      List<String> evidenceUrls,
      DateTime createdAt,
      DateTime? updatedAt,
      int flagCount,
      bool isHidden,
      int commentCount});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? anonymousUserId = null,
    Object? title = freezed,
    Object? content = null,
    Object? category = null,
    Object? subcategory = freezed,
    Object? location = freezed,
    Object? topics = null,
    Object? evidenceUrls = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? flagCount = null,
    Object? isHidden = null,
    Object? commentCount = null,
  }) {
    return _then(_$PostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      anonymousUserId: null == anonymousUserId
          ? _value.anonymousUserId
          : anonymousUserId // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      topics: null == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evidenceUrls: null == evidenceUrls
          ? _value._evidenceUrls
          : evidenceUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      flagCount: null == flagCount
          ? _value.flagCount
          : flagCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl extends _Post {
  const _$PostImpl(
      {required this.id,
      required this.anonymousUserId,
      this.title,
      required this.content,
      required this.category,
      this.subcategory,
      this.location,
      final List<String> topics = const [],
      final List<String> evidenceUrls = const [],
      required this.createdAt,
      this.updatedAt,
      this.flagCount = 0,
      this.isHidden = false,
      this.commentCount = 0})
      : _topics = topics,
        _evidenceUrls = evidenceUrls,
        super._();

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String id;
  @override
  final String anonymousUserId;
  @override
  final String? title;
  @override
  final String content;
  @override
  final String category;
  @override
  final String? subcategory;
  @override
  final String? location;
  final List<String> _topics;
  @override
  @JsonKey()
  List<String> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  final List<String> _evidenceUrls;
  @override
  @JsonKey()
  List<String> get evidenceUrls {
    if (_evidenceUrls is EqualUnmodifiableListView) return _evidenceUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evidenceUrls);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final int flagCount;
  @override
  @JsonKey()
  final bool isHidden;
  @override
  @JsonKey()
  final int commentCount;

  @override
  String toString() {
    return 'Post(id: $id, anonymousUserId: $anonymousUserId, title: $title, content: $content, category: $category, subcategory: $subcategory, location: $location, topics: $topics, evidenceUrls: $evidenceUrls, createdAt: $createdAt, updatedAt: $updatedAt, flagCount: $flagCount, isHidden: $isHidden, commentCount: $commentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.anonymousUserId, anonymousUserId) ||
                other.anonymousUserId == anonymousUserId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality()
                .equals(other._evidenceUrls, _evidenceUrls) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.flagCount, flagCount) ||
                other.flagCount == flagCount) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      anonymousUserId,
      title,
      content,
      category,
      subcategory,
      location,
      const DeepCollectionEquality().hash(_topics),
      const DeepCollectionEquality().hash(_evidenceUrls),
      createdAt,
      updatedAt,
      flagCount,
      isHidden,
      commentCount);

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post extends Post {
  const factory _Post(
      {required final String id,
      required final String anonymousUserId,
      final String? title,
      required final String content,
      required final String category,
      final String? subcategory,
      final String? location,
      final List<String> topics,
      final List<String> evidenceUrls,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final int flagCount,
      final bool isHidden,
      final int commentCount}) = _$PostImpl;
  const _Post._() : super._();

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String get id;
  @override
  String get anonymousUserId;
  @override
  String? get title;
  @override
  String get content;
  @override
  String get category;
  @override
  String? get subcategory;
  @override
  String? get location;
  @override
  List<String> get topics;
  @override
  List<String> get evidenceUrls;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int get flagCount;
  @override
  bool get isHidden;
  @override
  int get commentCount;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
