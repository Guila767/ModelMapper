// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generator_test.dart';

// **************************************************************************
// ModelMapperGenerator
// **************************************************************************

class $ModelTest_ModelFactory implements IModelFactory<ModelTest> {
  IModelBase Function(Map<String, dynamic> map) get fromMap =>
      ModelTest.fromJson;
}

// **************************************************************************
// FactoryMapperGenerator
// **************************************************************************

IModelFactory<T> _$TestFactoryGet<T extends IModelBase>() {
  switch (T) {
    case ModelTest:
      return $ModelTest_ModelFactory() as IModelFactory<T>;
    default:
      throw 'ModelMapper Error';
  }
}
