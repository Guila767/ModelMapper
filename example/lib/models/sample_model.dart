import 'package:json_annotation/json_annotation.dart';
import 'package:model_mapper/model_mapper.dart';

part 'sample_model.g.dart';

@JsonSerializable()
@ModelMapperModel()
class SampleModel implements IModelBase {
  final String message;
  SampleModel(this.message);
  
  @override
  Map<String, dynamic> toMap() => _$SampleModelToJson(this);

  factory SampleModel.fromJson(Map<String, dynamic> map) => _$SampleModelFromJson(map);
}