// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      json['name'] as String,
      json['age'] as int,
      DateTime.parse(json['birthday'] as String),
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'birthday': instance.birthday.toIso8601String(),
    };

// **************************************************************************
// ModelMapperGenerator
// **************************************************************************

class $PersonModel_ModelFactory implements IModelFactory<PersonModel> {
  IModelBase Function(Map<String, dynamic> map) get fromMap =>
      PersonModel.fromJson;
}
