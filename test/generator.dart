
import 'package:model_mapper/model_mapper.dart';

part 'generator.g.dart';

class TestFactory extends ModelFactoryBase {
  @override
  IModelFactoryMapper get generatorFactory => throw UnimplementedError();
}

class ModelTestFactory implements IModelFactory<ModelTest> {

  @override
  IModelBase<IModelFactory<ModelTest>> Function(Map<String, dynamic> map) get fromMap => throw UnimplementedError();
}

class ModelTest implements IModelBase<ModelTestFactory> {
  
  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}

void main() {
  final factory = TestFactory();
  var model = factory.getFactory<ModelTest>()!.fromMap({'': ''});
}