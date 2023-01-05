
abstract class IModelFactory<TModel extends IModelBase> {
  final IModelBase Function(Map<String, dynamic> map) fromMap;

  IModelFactory(this.fromMap);
}

abstract class IModelBase {
  Map<String, dynamic> toMap();
}

abstract class IModelMapperFactory {
  IModelFactory<T>? get<T extends IModelBase>();
}

enum MappingType {
  staticTypeCheck,
  runtimeTypeCaching
}

class FactoryConfig {
  final MappingType mappingType;

  const FactoryConfig(this.mappingType);

  static const FactoryConfig standart = FactoryConfig(MappingType.staticTypeCheck);
}

class ModelMapperFactory {
  final FactoryConfig config;
  const ModelMapperFactory([this.config = FactoryConfig.standart]);
}

class ModelMapperModel {
  final IModelBase Function(Map<String, dynamic> map)? fromMap;

  const ModelMapperModel({this.fromMap});
}