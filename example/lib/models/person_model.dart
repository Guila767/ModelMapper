import 'package:json_annotation/json_annotation.dart';
import 'package:model_mapper/model_mapper.dart';

part 'person_model.g.dart';

@JsonSerializable()
@ModelMapperModel()
class PersonModel implements IModelBase {
  final String name;
  final int age;
  final DateTime birthday;

  PersonModel(this.name, this.age, this.birthday);
  
  @override
  Map<String, dynamic> toMap() => _$PersonModelToJson(this);

  factory PersonModel.fromJson(Map<String, dynamic> map) => _$PersonModelFromJson(map);
}