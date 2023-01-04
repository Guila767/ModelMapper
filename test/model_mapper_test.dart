import 'dart:convert';

import 'package:model_mapper/model_mapper.dart';
import 'package:test/test.dart';

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

void main() {
  group('Encoder and decoder tests', () {
    final testFactory = ModelTestFactory();
    final model = testFactory.fromMap({'dummyField': 'hello world'}) as ModelTest;
    final modelJson = jsonEncode(model.toMap());

    test('From json', () {
      expect(model.dummyField, 'hello world');
    });

    test('To json', () {
      expect(modelJson, isNotNull);
    });
  });
}
