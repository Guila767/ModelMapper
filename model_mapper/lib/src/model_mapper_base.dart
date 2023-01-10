
abstract class IModelFactory<TModel extends IModelBase> {
  final IModelBase Function(Map<String, dynamic> map) fromMap;

  IModelFactory(this.fromMap);
}

abstract class IModelBase {
  Map<String, dynamic> toMap();
}

abstract class IModelMapperFactory {
  IModelFactory<T> get<T extends IModelBase>();
}

enum MappingType {
  staticTypeCheck,
  runtimeTypeCaching;

  factory MappingType.fromString(String name) {
    switch (name) {
      case 'staticTypeCheck':
        return MappingType.staticTypeCheck;
      case 'runtimeTypeCaching':
        return MappingType.runtimeTypeCaching;
      default:
        throw Exception('Invalid enum value');
    }
  }
}

class FactoryConfig {
  final MappingType mappingType;

  const FactoryConfig(this.mappingType);

  static const FactoryConfig standart = FactoryConfig(MappingType.staticTypeCheck);

  factory FactoryConfig.fromMap(Map<String, dynamic> map) => FactoryConfig(
    MappingType.fromString(map['mappingType'])
  );
}

class ModelMapperFactory {
  final FactoryConfig config;
  const ModelMapperFactory([this.config = FactoryConfig.standart]);
}

class ModelMapperModel {
  final IModelBase Function(Map<String, dynamic> map)? fromMap;

  const ModelMapperModel({this.fromMap});
}