
import 'package:analyzer/dart/element/element.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/template_generators/template_generator.dart';
import 'package:model_mapper/src/internals/utils.dart';

class FactoryTemplateGenerator extends TemplateGenerator {
  
  final FactoryConfig config;
  String get factoryName => '_\$${_elementName}Get';

  FactoryTemplateGenerator(String elementName, this.config) : super() {
    _elementName = elementName;
  }
  
  @override
  String generate() {
    addMethod(factoryName, Type.fromName('IModelFactory<T>'))
      ..withGeneric('T extends IModelBase')
      ..withBody(_generateStaticMapper());

    return super.generate();
  }

  String _generateStaticMapper() {
    var builder = TokenBuilder();
    builder
      ..writeToken('switch')
      ..writeToken('(T)')
      ..startObjectBody();
    
    for (var model in _modelClasses) {
      if (!model.isGeneric) {
        builder
        ..writeToken('case')
        ..writeToken(model.name)
        ..writeToken(':')
        ..writeToken('return')
        ..writeToken('\$${model.name}_ModelFactory()')
        ..writeExpression('as IModelFactory<T>;');
        continue;
      }
      final typeParameters = _modelClasses
        .where((klass) => 
          klass.name != model.name &&
          klass.allSupertypes
            .any((superType) =>
              superType.element.displayName ==
              model.typeParameters.first.bound!.element!.displayName));
      for (var typeParam in typeParameters) {
        builder
        ..writeToken('case')
        ..writeToken(model.name)
        ..writeToken('<')
        ..writeToken(typeParam.displayName)
        ..writeExpression('>')
        ..writeToken(':')
        ..writeToken('return')
        ..writeToken('\$${model.name}_ModelFactory()')
        ..writeExpression('as IModelFactory<T>;');
      }
    }
    builder.writeExpression('default: throw \'ModelMapper Error\';');
    builder.endObjectBody();
    return builder.toString();
  }

  void addModel(ClassElement element) => _modelClasses.add(element);
  void addModels(Iterable<ClassElement> elemets) => _modelClasses.addAll(elemets);

  final _modelClasses = <ClassElement>[];
  late final String _elementName;
}