import 'dart:convert';
import 'package:model_mapper/model_mapper.dart';

class ModelTestFactory implements IModelFactory<ModelTest> {
  @override
  IModelBase<IModelFactory<ModelTest>> Function(Map<String, dynamic> map) get fromMap => ModelTest.fromJson;
}

class ModelTest implements IModelBase<ModelTestFactory> {
  
  final String dummyField;

  ModelTest(this.dummyField);

  @override
  Map<String, dynamic> toMap() => {
    'dummyField': dummyField
  };

  factory ModelTest.fromJson(Map<String, dynamic> json) => 
    ModelTest(json['dummyField'] ?? '');
}

class FactoryTest {
  final factoryMap = {
    ModelTest: () => ModelTestFactory()
  };

  IModelFactory<T>? getFactory<T extends IModelBase<IModelFactory<T>>>() {
    final factory = factoryMap[T];
    if (factory == null) {
      return null;
    }
    return factory() as IModelFactory<T>?;
  }
}

void main() {
  final testFactory = FactoryTest().getFactory<ModelTest>();
  if (testFactory == null) {
    print('factory is null');
    return;
  }
  final model = testFactory.fromMap({'dummyField': 'hello world'}) as ModelTest;
  final modelJson = jsonEncode(model.toMap());

  print('From json: ${model.dummyField}');
  print('To json: $modelJson');
}
