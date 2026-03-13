// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Project _$ProjectFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'commercial':
          return CommercialProject.fromJson(
            json
          );
                case 'personal':
          return PersonalProject.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'Project',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$Project {

 String get id; String get name; String? get description; List<String> get techStack; int get sortOrder;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.techStack, techStack)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(techStack),sortOrder);

@override
String toString() {
  return 'Project(id: $id, name: $name, description: $description, techStack: $techStack, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, List<String> techStack, int sortOrder
});




}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? techStack = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,techStack: null == techStack ? _self.techStack : techStack // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CommercialProject value)?  commercial,TResult Function( PersonalProject value)?  personal,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CommercialProject() when commercial != null:
return commercial(_that);case PersonalProject() when personal != null:
return personal(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CommercialProject value)  commercial,required TResult Function( PersonalProject value)  personal,}){
final _that = this;
switch (_that) {
case CommercialProject():
return commercial(_that);case PersonalProject():
return personal(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CommercialProject value)?  commercial,TResult? Function( PersonalProject value)?  personal,}){
final _that = this;
switch (_that) {
case CommercialProject() when commercial != null:
return commercial(_that);case PersonalProject() when personal != null:
return personal(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String name,  String company,  String role,  String? description,  List<String> techStack,  List<String> responsibilities,  int sortOrder)?  commercial,TResult Function( String id,  String name,  String? description,  List<String> techStack,  String? githubUrl,  int sortOrder)?  personal,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CommercialProject() when commercial != null:
return commercial(_that.id,_that.name,_that.company,_that.role,_that.description,_that.techStack,_that.responsibilities,_that.sortOrder);case PersonalProject() when personal != null:
return personal(_that.id,_that.name,_that.description,_that.techStack,_that.githubUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String name,  String company,  String role,  String? description,  List<String> techStack,  List<String> responsibilities,  int sortOrder)  commercial,required TResult Function( String id,  String name,  String? description,  List<String> techStack,  String? githubUrl,  int sortOrder)  personal,}) {final _that = this;
switch (_that) {
case CommercialProject():
return commercial(_that.id,_that.name,_that.company,_that.role,_that.description,_that.techStack,_that.responsibilities,_that.sortOrder);case PersonalProject():
return personal(_that.id,_that.name,_that.description,_that.techStack,_that.githubUrl,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String name,  String company,  String role,  String? description,  List<String> techStack,  List<String> responsibilities,  int sortOrder)?  commercial,TResult? Function( String id,  String name,  String? description,  List<String> techStack,  String? githubUrl,  int sortOrder)?  personal,}) {final _that = this;
switch (_that) {
case CommercialProject() when commercial != null:
return commercial(_that.id,_that.name,_that.company,_that.role,_that.description,_that.techStack,_that.responsibilities,_that.sortOrder);case PersonalProject() when personal != null:
return personal(_that.id,_that.name,_that.description,_that.techStack,_that.githubUrl,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class CommercialProject implements Project {
  const CommercialProject({required this.id, required this.name, required this.company, required this.role, this.description, final  List<String> techStack = const [], final  List<String> responsibilities = const [], this.sortOrder = 0, final  String? $type}): _techStack = techStack,_responsibilities = responsibilities,$type = $type ?? 'commercial';
  factory CommercialProject.fromJson(Map<String, dynamic> json) => _$CommercialProjectFromJson(json);

@override final  String id;
@override final  String name;
 final  String company;
 final  String role;
@override final  String? description;
 final  List<String> _techStack;
@override@JsonKey() List<String> get techStack {
  if (_techStack is EqualUnmodifiableListView) return _techStack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_techStack);
}

 final  List<String> _responsibilities;
@JsonKey() List<String> get responsibilities {
  if (_responsibilities is EqualUnmodifiableListView) return _responsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responsibilities);
}

@override@JsonKey() final  int sortOrder;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommercialProjectCopyWith<CommercialProject> get copyWith => _$CommercialProjectCopyWithImpl<CommercialProject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommercialProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommercialProject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.company, company) || other.company == company)&&(identical(other.role, role) || other.role == role)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._techStack, _techStack)&&const DeepCollectionEquality().equals(other._responsibilities, _responsibilities)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,company,role,description,const DeepCollectionEquality().hash(_techStack),const DeepCollectionEquality().hash(_responsibilities),sortOrder);

@override
String toString() {
  return 'Project.commercial(id: $id, name: $name, company: $company, role: $role, description: $description, techStack: $techStack, responsibilities: $responsibilities, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $CommercialProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory $CommercialProjectCopyWith(CommercialProject value, $Res Function(CommercialProject) _then) = _$CommercialProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String company, String role, String? description, List<String> techStack, List<String> responsibilities, int sortOrder
});




}
/// @nodoc
class _$CommercialProjectCopyWithImpl<$Res>
    implements $CommercialProjectCopyWith<$Res> {
  _$CommercialProjectCopyWithImpl(this._self, this._then);

  final CommercialProject _self;
  final $Res Function(CommercialProject) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? company = null,Object? role = null,Object? description = freezed,Object? techStack = null,Object? responsibilities = null,Object? sortOrder = null,}) {
  return _then(CommercialProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,techStack: null == techStack ? _self._techStack : techStack // ignore: cast_nullable_to_non_nullable
as List<String>,responsibilities: null == responsibilities ? _self._responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PersonalProject implements Project {
  const PersonalProject({required this.id, required this.name, this.description, final  List<String> techStack = const [], this.githubUrl, this.sortOrder = 0, final  String? $type}): _techStack = techStack,$type = $type ?? 'personal';
  factory PersonalProject.fromJson(Map<String, dynamic> json) => _$PersonalProjectFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
 final  List<String> _techStack;
@override@JsonKey() List<String> get techStack {
  if (_techStack is EqualUnmodifiableListView) return _techStack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_techStack);
}

 final  String? githubUrl;
@override@JsonKey() final  int sortOrder;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalProjectCopyWith<PersonalProject> get copyWith => _$PersonalProjectCopyWithImpl<PersonalProject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalProject&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._techStack, _techStack)&&(identical(other.githubUrl, githubUrl) || other.githubUrl == githubUrl)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,const DeepCollectionEquality().hash(_techStack),githubUrl,sortOrder);

@override
String toString() {
  return 'Project.personal(id: $id, name: $name, description: $description, techStack: $techStack, githubUrl: $githubUrl, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $PersonalProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory $PersonalProjectCopyWith(PersonalProject value, $Res Function(PersonalProject) _then) = _$PersonalProjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, List<String> techStack, String? githubUrl, int sortOrder
});




}
/// @nodoc
class _$PersonalProjectCopyWithImpl<$Res>
    implements $PersonalProjectCopyWith<$Res> {
  _$PersonalProjectCopyWithImpl(this._self, this._then);

  final PersonalProject _self;
  final $Res Function(PersonalProject) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? techStack = null,Object? githubUrl = freezed,Object? sortOrder = null,}) {
  return _then(PersonalProject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,techStack: null == techStack ? _self._techStack : techStack // ignore: cast_nullable_to_non_nullable
as List<String>,githubUrl: freezed == githubUrl ? _self.githubUrl : githubUrl // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
