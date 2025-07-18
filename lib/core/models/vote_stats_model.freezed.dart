// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_stats_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoteStatsModel _$VoteStatsModelFromJson(Map<String, dynamic> json) {
  return _VoteStatsModel.fromJson(json);
}

/// @nodoc
mixin _$VoteStatsModel {
  String get postId => throw _privateConstructorUsedError;
  int get upvotes => throw _privateConstructorUsedError;
  int get downvotes => throw _privateConstructorUsedError;

  /// Serializes this VoteStatsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoteStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteStatsModelCopyWith<VoteStatsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteStatsModelCopyWith<$Res> {
  factory $VoteStatsModelCopyWith(
          VoteStatsModel value, $Res Function(VoteStatsModel) then) =
      _$VoteStatsModelCopyWithImpl<$Res, VoteStatsModel>;
  @useResult
  $Res call({String postId, int upvotes, int downvotes});
}

/// @nodoc
class _$VoteStatsModelCopyWithImpl<$Res, $Val extends VoteStatsModel>
    implements $VoteStatsModelCopyWith<$Res> {
  _$VoteStatsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? upvotes = null,
    Object? downvotes = null,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      upvotes: null == upvotes
          ? _value.upvotes
          : upvotes // ignore: cast_nullable_to_non_nullable
              as int,
      downvotes: null == downvotes
          ? _value.downvotes
          : downvotes // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteStatsModelImplCopyWith<$Res>
    implements $VoteStatsModelCopyWith<$Res> {
  factory _$$VoteStatsModelImplCopyWith(_$VoteStatsModelImpl value,
          $Res Function(_$VoteStatsModelImpl) then) =
      __$$VoteStatsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String postId, int upvotes, int downvotes});
}

/// @nodoc
class __$$VoteStatsModelImplCopyWithImpl<$Res>
    extends _$VoteStatsModelCopyWithImpl<$Res, _$VoteStatsModelImpl>
    implements _$$VoteStatsModelImplCopyWith<$Res> {
  __$$VoteStatsModelImplCopyWithImpl(
      _$VoteStatsModelImpl _value, $Res Function(_$VoteStatsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? upvotes = null,
    Object? downvotes = null,
  }) {
    return _then(_$VoteStatsModelImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      upvotes: null == upvotes
          ? _value.upvotes
          : upvotes // ignore: cast_nullable_to_non_nullable
              as int,
      downvotes: null == downvotes
          ? _value.downvotes
          : downvotes // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteStatsModelImpl implements _VoteStatsModel {
  const _$VoteStatsModelImpl(
      {required this.postId, required this.upvotes, required this.downvotes});

  factory _$VoteStatsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteStatsModelImplFromJson(json);

  @override
  final String postId;
  @override
  final int upvotes;
  @override
  final int downvotes;

  @override
  String toString() {
    return 'VoteStatsModel(postId: $postId, upvotes: $upvotes, downvotes: $downvotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteStatsModelImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.upvotes, upvotes) || other.upvotes == upvotes) &&
            (identical(other.downvotes, downvotes) ||
                other.downvotes == downvotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, postId, upvotes, downvotes);

  /// Create a copy of VoteStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteStatsModelImplCopyWith<_$VoteStatsModelImpl> get copyWith =>
      __$$VoteStatsModelImplCopyWithImpl<_$VoteStatsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteStatsModelImplToJson(
      this,
    );
  }
}

abstract class _VoteStatsModel implements VoteStatsModel {
  const factory _VoteStatsModel(
      {required final String postId,
      required final int upvotes,
      required final int downvotes}) = _$VoteStatsModelImpl;

  factory _VoteStatsModel.fromJson(Map<String, dynamic> json) =
      _$VoteStatsModelImpl.fromJson;

  @override
  String get postId;
  @override
  int get upvotes;
  @override
  int get downvotes;

  /// Create a copy of VoteStatsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteStatsModelImplCopyWith<_$VoteStatsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
