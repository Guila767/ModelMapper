import 'package:model_mapper/model_mapper.dart';

// part 'generator.model_mapper.g.dart';
part 'generator.model_mapper.g.dart';

@ModelMapperFactory()
class TestFactory implements IModelMapperFactory {
  @override
  IModelFactory<T>? get<T extends IModelBase>() {
    // TODO: implement get
    throw UnimplementedError();
  }
}

@ModelMapperModel()
class ModelTest implements IModelBase {
  
  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}

void main() {
  final factory = TestFactory();
  var model = factory.get<ModelTest>()!.fromMap({'': ''});
}