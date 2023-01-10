// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleModel _$SampleModelFromJson(Map<String, dynamic> json) => SampleModel(
      json['message'] as String,
    );

Map<String, dynamic> _$SampleModelToJson(SampleModel instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

// **************************************************************************
// ModelMapperGenerator
// **************************************************************************

class $SampleModel_ModelFactory implements IModelFactory<SampleModel> {
  IModelBase Function(Map<String, dynamic> map) get fromMap =>
      SampleModel.fromJson;
}
