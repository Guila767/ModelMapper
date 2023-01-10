import 'package:test/test.dart';
import 'package:model_mapper/model_mapper.dart';

part 'generator_test.g.dart';

@ModelMapperFactory()
class TestFactory implements IModelMapperFactory {
  @override
  IModelFactory<T> get<T extends IModelBase>() => $TestFactory_get<T>();
}

@ModelMapperModel()
class ModelTest implements IModelBase {
  final String test;
  const ModelTest(this.test);
  
  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }

  factory ModelTest.fromJson(Map<String, dynamic> map) => ModelTest(
    map['test']
  );
}

void main() {
  final factory = TestFactory();
  const message = 'hello world';

  test('factory test', () {
    var model = factory.get<ModelTest>().fromMap({'test': message}) as ModelTest;
    expect(model.test, message);
  });

}