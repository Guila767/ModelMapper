
import 'package:model_mapper/src/model_mapper_base.dart';

part 'generic_model_test.g.dart';

@ModelMapperFactory()
class GenericFactory implements IModelMapperFactory {
  
  @override
  IModelFactory<T> get<T extends IModelBase>() => _$GenericFactoryGet<T>();

}

@ModelMapperModel()
class ModelBase<T extends IModelBase> implements IModelBase {
  final String name;
  final T data;

  ModelBase(this.name, this.data);
  
  @override
  Map<String, dynamic> toMap() => {
    'name': name,
    'data': (data as dynamic).toJson()
  };

  factory ModelBase.fromJson(Map<String, dynamic> map) => GenericFactory().get<T>().fromMap(map) as ModelBase<T>;
}

@ModelMapperModel()
class ModelA implements IModelBase {
  final String modelField;
  ModelA(this.modelField);
  
  @override
  Map<String, dynamic> toMap() => {
    'modelField': modelField
  };

  factory ModelA.fromJson(Map<String, dynamic> map) => ModelA(map['modelField']);
}

@ModelMapperModel()
class ModelB implements ModelBase<ModelA> {
  @override
  final ModelA data;
  @override
  final String name;
  ModelB(this.data, this.name);
  @override
  Map<String, dynamic> toMap() => {
    'data': data.toMap(),
    'name': name
  };

  factory ModelB.fromJson(Map<String, dynamic> map) => ModelB(map['data'], map['name']);
}

void main() {
  final obj = GenericFactory().get<ModelBase<ModelA>>();
  print(obj);
}

