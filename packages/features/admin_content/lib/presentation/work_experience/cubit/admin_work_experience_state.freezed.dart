// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_work_experience_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminWorkExperienceState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminWorkExperienceState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminWorkExperienceState()';
}


}

/// @nodoc
class $AdminWorkExperienceStateCopyWith<$Res>  {
$AdminWorkExperienceStateCopyWith(AdminWorkExperienceState _, $Res Function(AdminWorkExperienceState) __);
}


/// Adds pattern-matching-related methods to [AdminWorkExperienceState].
extension AdminWorkExperienceStatePatterns on AdminWorkExperienceState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _InitialState value)?  initial,TResult Function( _LoadingState value)?  loading,TResult Function( _LoadedState value)?  loaded,TResult Function( _SavingState value)?  saving,TResult Function( _ErrorState value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialState() when initial != null:
return initial(_that);case _LoadingState() when loading != null:
return loading(_that);case _LoadedState() when loaded != null:
return loaded(_that);case _SavingState() when saving != null:
return saving(_that);case _ErrorState() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _InitialState value)  initial,required TResult Function( _LoadingState value)  loading,required TResult Function( _LoadedState value)  loaded,required TResult Function( _SavingState value)  saving,required TResult Function( _ErrorState value)  error,}){
final _that = this;
switch (_that) {
case _InitialState():
return initial(_that);case _LoadingState():
return loading(_that);case _LoadedState():
return loaded(_that);case _SavingState():
return saving(_that);case _ErrorState():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _InitialState value)?  initial,TResult? Function( _LoadingState value)?  loading,TResult? Function( _LoadedState value)?  loaded,TResult? Function( _SavingState value)?  saving,TResult? Function( _ErrorState value)?  error,}){
final _that = this;
switch (_that) {
case _InitialState() when initial != null:
return initial(_that);case _LoadingState() when loading != null:
return loading(_that);case _LoadedState() when loaded != null:
return loaded(_that);case _SavingState() when saving != null:
return saving(_that);case _ErrorState() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<WorkExperience> workExperiences)?  loaded,TResult Function( List<WorkExperience> workExperiences)?  saving,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialState() when initial != null:
return initial();case _LoadingState() when loading != null:
return loading();case _LoadedState() when loaded != null:
return loaded(_that.workExperiences);case _SavingState() when saving != null:
return saving(_that.workExperiences);case _ErrorState() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<WorkExperience> workExperiences)  loaded,required TResult Function( List<WorkExperience> workExperiences)  saving,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _InitialState():
return initial();case _LoadingState():
return loading();case _LoadedState():
return loaded(_that.workExperiences);case _SavingState():
return saving(_that.workExperiences);case _ErrorState():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<WorkExperience> workExperiences)?  loaded,TResult? Function( List<WorkExperience> workExperiences)?  saving,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _InitialState() when initial != null:
return initial();case _LoadingState() when loading != null:
return loading();case _LoadedState() when loaded != null:
return loaded(_that.workExperiences);case _SavingState() when saving != null:
return saving(_that.workExperiences);case _ErrorState() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _InitialState implements AdminWorkExperienceState {
  const _InitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminWorkExperienceState.initial()';
}


}




/// @nodoc


class _LoadingState implements AdminWorkExperienceState {
  const _LoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AdminWorkExperienceState.loading()';
}


}




/// @nodoc


class _LoadedState implements AdminWorkExperienceState {
  const _LoadedState({required final  List<WorkExperience> workExperiences}): _workExperiences = workExperiences;
  

 final  List<WorkExperience> _workExperiences;
 List<WorkExperience> get workExperiences {
  if (_workExperiences is EqualUnmodifiableListView) return _workExperiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workExperiences);
}


/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedStateCopyWith<_LoadedState> get copyWith => __$LoadedStateCopyWithImpl<_LoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadedState&&const DeepCollectionEquality().equals(other._workExperiences, _workExperiences));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_workExperiences));

@override
String toString() {
  return 'AdminWorkExperienceState.loaded(workExperiences: $workExperiences)';
}


}

/// @nodoc
abstract mixin class _$LoadedStateCopyWith<$Res> implements $AdminWorkExperienceStateCopyWith<$Res> {
  factory _$LoadedStateCopyWith(_LoadedState value, $Res Function(_LoadedState) _then) = __$LoadedStateCopyWithImpl;
@useResult
$Res call({
 List<WorkExperience> workExperiences
});




}
/// @nodoc
class __$LoadedStateCopyWithImpl<$Res>
    implements _$LoadedStateCopyWith<$Res> {
  __$LoadedStateCopyWithImpl(this._self, this._then);

  final _LoadedState _self;
  final $Res Function(_LoadedState) _then;

/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workExperiences = null,}) {
  return _then(_LoadedState(
workExperiences: null == workExperiences ? _self._workExperiences : workExperiences // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,
  ));
}


}

/// @nodoc


class _SavingState implements AdminWorkExperienceState {
  const _SavingState({required final  List<WorkExperience> workExperiences}): _workExperiences = workExperiences;
  

 final  List<WorkExperience> _workExperiences;
 List<WorkExperience> get workExperiences {
  if (_workExperiences is EqualUnmodifiableListView) return _workExperiences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workExperiences);
}


/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingStateCopyWith<_SavingState> get copyWith => __$SavingStateCopyWithImpl<_SavingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingState&&const DeepCollectionEquality().equals(other._workExperiences, _workExperiences));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_workExperiences));

@override
String toString() {
  return 'AdminWorkExperienceState.saving(workExperiences: $workExperiences)';
}


}

/// @nodoc
abstract mixin class _$SavingStateCopyWith<$Res> implements $AdminWorkExperienceStateCopyWith<$Res> {
  factory _$SavingStateCopyWith(_SavingState value, $Res Function(_SavingState) _then) = __$SavingStateCopyWithImpl;
@useResult
$Res call({
 List<WorkExperience> workExperiences
});




}
/// @nodoc
class __$SavingStateCopyWithImpl<$Res>
    implements _$SavingStateCopyWith<$Res> {
  __$SavingStateCopyWithImpl(this._self, this._then);

  final _SavingState _self;
  final $Res Function(_SavingState) _then;

/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? workExperiences = null,}) {
  return _then(_SavingState(
workExperiences: null == workExperiences ? _self._workExperiences : workExperiences // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,
  ));
}


}

/// @nodoc


class _ErrorState implements AdminWorkExperienceState {
  const _ErrorState({required this.message});
  

 final  String message;

/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorStateCopyWith<_ErrorState> get copyWith => __$ErrorStateCopyWithImpl<_ErrorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorState&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AdminWorkExperienceState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorStateCopyWith<$Res> implements $AdminWorkExperienceStateCopyWith<$Res> {
  factory _$ErrorStateCopyWith(_ErrorState value, $Res Function(_ErrorState) _then) = __$ErrorStateCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorStateCopyWithImpl<$Res>
    implements _$ErrorStateCopyWith<$Res> {
  __$ErrorStateCopyWithImpl(this._self, this._then);

  final _ErrorState _self;
  final $Res Function(_ErrorState) _then;

/// Create a copy of AdminWorkExperienceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_ErrorState(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
