// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_vote_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostVoteState {
  int get truthfulVotes => throw _privateConstructorUsedError;
  int get deceptiveVotes => throw _privateConstructorUsedError;
  VoteType? get currentUserVote => throw _privateConstructorUsedError;

  /// Create a copy of PostVoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostVoteStateCopyWith<PostVoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostVoteStateCopyWith<$Res> {
  factory $PostVoteStateCopyWith(
          PostVoteState value, $Res Function(PostVoteState) then) =
      _$PostVoteStateCopyWithImpl<$Res, PostVoteState>;
  @useResult
  $Res call({int truthfulVotes, int deceptiveVotes, VoteType? currentUserVote});
}

/// @nodoc
class _$PostVoteStateCopyWithImpl<$Res, $Val extends PostVoteState>
    implements $PostVoteStateCopyWith<$Res> {
  _$PostVoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostVoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truthfulVotes = null,
    Object? deceptiveVotes = null,
    Object? currentUserVote = freezed,
  }) {
    return _then(_value.copyWith(
      truthfulVotes: null == truthfulVotes
          ? _value.truthfulVotes
          : truthfulVotes // ignore: cast_nullable_to_non_nullable
              as int,
      deceptiveVotes: null == deceptiveVotes
          ? _value.deceptiveVotes
          : deceptiveVotes // ignore: cast_nullable_to_non_nullable
              as int,
      currentUserVote: freezed == currentUserVote
          ? _value.currentUserVote
          : currentUserVote // ignore: cast_nullable_to_non_nullable
              as VoteType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostVoteStateImplCopyWith<$Res>
    implements $PostVoteStateCopyWith<$Res> {
  factory _$$PostVoteStateImplCopyWith(
          _$PostVoteStateImpl value, $Res Function(_$PostVoteStateImpl) then) =
      __$$PostVoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int truthfulVotes, int deceptiveVotes, VoteType? currentUserVote});
}

/// @nodoc
class __$$PostVoteStateImplCopyWithImpl<$Res>
    extends _$PostVoteStateCopyWithImpl<$Res, _$PostVoteStateImpl>
    implements _$$PostVoteStateImplCopyWith<$Res> {
  __$$PostVoteStateImplCopyWithImpl(
      _$PostVoteStateImpl _value, $Res Function(_$PostVoteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostVoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? truthfulVotes = null,
    Object? deceptiveVotes = null,
    Object? currentUserVote = freezed,
  }) {
    return _then(_$PostVoteStateImpl(
      truthfulVotes: null == truthfulVotes
          ? _value.truthfulVotes
          : truthfulVotes // ignore: cast_nullable_to_non_nullable
              as int,
      deceptiveVotes: null == deceptiveVotes
          ? _value.deceptiveVotes
          : deceptiveVotes // ignore: cast_nullable_to_non_nullable
              as int,
      currentUserVote: freezed == currentUserVote
          ? _value.currentUserVote
          : currentUserVote // ignore: cast_nullable_to_non_nullable
              as VoteType?,
    ));
  }
}

/// @nodoc

class _$PostVoteStateImpl implements _PostVoteState {
  const _$PostVoteStateImpl(
      {required this.truthfulVotes,
      required this.deceptiveVotes,
      this.currentUserVote});

  @override
  final int truthfulVotes;
  @override
  final int deceptiveVotes;
  @override
  final VoteType? currentUserVote;

  @override
  String toString() {
    return 'PostVoteState(truthfulVotes: $truthfulVotes, deceptiveVotes: $deceptiveVotes, currentUserVote: $currentUserVote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostVoteStateImpl &&
            (identical(other.truthfulVotes, truthfulVotes) ||
                other.truthfulVotes == truthfulVotes) &&
            (identical(other.deceptiveVotes, deceptiveVotes) ||
                other.deceptiveVotes == deceptiveVotes) &&
            (identical(other.currentUserVote, currentUserVote) ||
                other.currentUserVote == currentUserVote));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, truthfulVotes, deceptiveVotes, currentUserVote);

  /// Create a copy of PostVoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostVoteStateImplCopyWith<_$PostVoteStateImpl> get copyWith =>
      __$$PostVoteStateImplCopyWithImpl<_$PostVoteStateImpl>(this, _$identity);
}

abstract class _PostVoteState implements PostVoteState {
  const factory _PostVoteState(
      {required final int truthfulVotes,
      required final int deceptiveVotes,
      final VoteType? currentUserVote}) = _$PostVoteStateImpl;

  @override
  int get truthfulVotes;
  @override
  int get deceptiveVotes;
  @override
  VoteType? get currentUserVote;

  /// Create a copy of PostVoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostVoteStateImplCopyWith<_$PostVoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
