import 'package:model_mapper/model_mapper.dart';
import 'sample_factory.factory_library.g.dart';

part 'sample_factory.g.dart';

@ModelMapperFactory()
class SampleFactory implements IModelMapperFactory {
  static const SampleFactory _singleton = SampleFactory._internal();
  factory SampleFactory() {
    return _singleton;
  }
  const SampleFactory._internal();

  @override
  IModelFactory<T> get<T extends IModelBase>() => $SampleFactory_get<T>();
}