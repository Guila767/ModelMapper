// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_model_test.dart';

// **************************************************************************
// ModelMapperGenerator
// **************************************************************************

class $ModelBase_ModelFactory implements IModelFactory<ModelBase> {
  IModelBase Function(Map<String, dynamic> map) get fromMap =>
      ModelBase.fromJson;
}

class $ModelA_ModelFactory implements IModelFactory<ModelA> {
  IModelBase Function(Map<String, dynamic> map) get fromMap => ModelA.fromJson;
}

class $ModelB_ModelFactory implements IModelFactory<ModelB> {
  IModelBase Function(Map<String, dynamic> map) get fromMap => ModelB.fromJson;
}

// **************************************************************************
// FactoryMapperGenerator
// **************************************************************************

IModelFactory<T> _$GenericFactoryGet<T extends IModelBase>() {
  switch (T) {
    case ModelBase<ModelA>:
      return $ModelBase_ModelFactory() as IModelFactory<T>;
    case ModelBase<ModelB>:
      return $ModelBase_ModelFactory() as IModelFactory<T>;
    case ModelA:
      return $ModelA_ModelFactory() as IModelFactory<T>;
    case ModelB:
      return $ModelB_ModelFactory() as IModelFactory<T>;
    default:
      throw 'ModelMapper Error';
  }
}
