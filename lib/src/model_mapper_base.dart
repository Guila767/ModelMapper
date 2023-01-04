
abstract class IModelFactory<TModel extends IModelBase<IModelFactory<TModel>>> {
  final IModelBase<IModelFactory<TModel>> Function(Map<String, dynamic> map) fromMap;

  IModelFactory(this.fromMap);
}

abstract class IModelBase<TModelFactory extends IModelFactory<IModelBase<TModelFactory>>> {
  Map<String, dynamic> toMap();
}

abstract class IModelFactoryMapper {
  IModelFactory<T>? get<T extends IModelBase<IModelFactory<T>>>();
}

abstract class ModelFactoryBase {
  IModelFactoryMapper get generatorFactory;
  late final _factory = generatorFactory;

  IModelFactory<T>? getFactory<T extends IModelBase<IModelFactory<T>>>() => _factory.get<T>();
}

enum MappingType {
  staticTypeCheck,
  runtimeTypeCaching
}

class FactoryConfig {
  final MappingType mappingType;
  final String? generatorFactoryFunctionName;

  FactoryConfig(this.mappingType, {this.generatorFactoryFunctionName});
}