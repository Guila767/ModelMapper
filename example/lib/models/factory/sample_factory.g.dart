// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_factory.dart';

// **************************************************************************
// FactoryMapperGenerator
// **************************************************************************

IModelFactory<T> $SampleFactory_get<T extends IModelBase>() {
  switch (T) {
    case PersonModel:
      return $PersonModel_ModelFactory() as IModelFactory<T>;
    case SampleModel:
      return $SampleModel_ModelFactory() as IModelFactory<T>;
    default:
      throw 'ModelMapper Error';
  }
}
