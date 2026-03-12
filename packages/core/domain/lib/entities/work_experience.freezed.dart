// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_experience.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkExperience {

 String get id; String get title; String get company; DateTime get startDate; DateTime? get endDate; List<String> get responsibilities; int get sortOrder;
/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceCopyWith<WorkExperience> get copyWith => _$WorkExperienceCopyWithImpl<WorkExperience>(this as WorkExperience, _$identity);

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperience&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.responsibilities, responsibilities)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,startDate,endDate,const DeepCollectionEquality().hash(responsibilities),sortOrder);

@override
String toString() {
  return 'WorkExperience(id: $id, title: $title, company: $company, startDate: $startDate, endDate: $endDate, responsibilities: $responsibilities, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceCopyWith<$Res>  {
  factory $WorkExperienceCopyWith(WorkExperience value, $Res Function(WorkExperience) _then) = _$WorkExperienceCopyWithImpl;
@useResult
$Res call({
 String id, String title, String company, DateTime startDate, DateTime? endDate, List<String> responsibilities, int sortOrder
});




}
/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._self, this._then);

  final WorkExperience _self;
  final $Res Function(WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? company = null,Object? startDate = null,Object? endDate = freezed,Object? responsibilities = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsibilities: null == responsibilities ? _self.responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkExperience].
extension WorkExperiencePatterns on WorkExperience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkExperience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkExperience value)  $default,){
final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkExperience value)?  $default,){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String company,  DateTime startDate,  DateTime? endDate,  List<String> responsibilities,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.startDate,_that.endDate,_that.responsibilities,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String company,  DateTime startDate,  DateTime? endDate,  List<String> responsibilities,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that.id,_that.title,_that.company,_that.startDate,_that.endDate,_that.responsibilities,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String company,  DateTime startDate,  DateTime? endDate,  List<String> responsibilities,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.startDate,_that.endDate,_that.responsibilities,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkExperience extends WorkExperience {
  const _WorkExperience({required this.id, required this.title, required this.company, required this.startDate, this.endDate, final  List<String> responsibilities = const [], this.sortOrder = 0}): _responsibilities = responsibilities,super._();
  factory _WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);

@override final  String id;
@override final  String title;
@override final  String company;
@override final  DateTime startDate;
@override final  DateTime? endDate;
 final  List<String> _responsibilities;
@override@JsonKey() List<String> get responsibilities {
  if (_responsibilities is EqualUnmodifiableListView) return _responsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responsibilities);
}

@override@JsonKey() final  int sortOrder;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkExperienceCopyWith<_WorkExperience> get copyWith => __$WorkExperienceCopyWithImpl<_WorkExperience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperience&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._responsibilities, _responsibilities)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,startDate,endDate,const DeepCollectionEquality().hash(_responsibilities),sortOrder);

@override
String toString() {
  return 'WorkExperience(id: $id, title: $title, company: $company, startDate: $startDate, endDate: $endDate, responsibilities: $responsibilities, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceCopyWith<$Res> implements $WorkExperienceCopyWith<$Res> {
  factory _$WorkExperienceCopyWith(_WorkExperience value, $Res Function(_WorkExperience) _then) = __$WorkExperienceCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String company, DateTime startDate, DateTime? endDate, List<String> responsibilities, int sortOrder
});




}
/// @nodoc
class __$WorkExperienceCopyWithImpl<$Res>
    implements _$WorkExperienceCopyWith<$Res> {
  __$WorkExperienceCopyWithImpl(this._self, this._then);

  final _WorkExperience _self;
  final $Res Function(_WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? company = null,Object? startDate = null,Object? endDate = freezed,Object? responsibilities = null,Object? sortOrder = null,}) {
  return _then(_WorkExperience(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,responsibilities: null == responsibilities ? _self._responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
