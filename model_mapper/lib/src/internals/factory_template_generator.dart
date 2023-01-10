
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/template_generators/template_generator.dart';
import 'package:source_gen/source_gen.dart';

class FactoryTemplateGenerator extends TemplateGenerator {
  FactoryTemplateGenerator(this.element, this.annotation) : super() {
    var configObj = annotation.read('config').objectValue; 
    var objEntries = (configObj.type as InterfaceType).accessors
      .where((element) => 
        !element.isStatic && element.isGetter && element.isPublic)
      .map((e) => MapEntry(e.name, configObj.getField(e.name)!.variable!.name));
    _config = FactoryConfig.fromMap(Map.fromEntries(objEntries));
  }

  @override
  String generate() {
    final targetName = '\$${element.name}_get';

    addMethod(targetName, Type.fromName('IModelFactory<T>'))
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
      builder
        ..writeToken('case')
        ..writeToken(model.name)
        ..writeToken(':')
        ..writeToken('return')
        ..writeToken('\$${model.name}_ModelFactory()')
        ..writeExpression('as IModelFactory<T>;');
    }
    builder.writeExpression('default: throw \'ModelMapper Error\';');
    builder.endObjectBody();
    return builder.toString();
  }

  void addModel(ClassElement element) => _modelClasses.add(element);
  void addModels(Iterable<ClassElement> elemets) => _modelClasses.addAll(elemets);

  final _modelClasses = <ClassElement>[];
  final Element element;
  final ConstantReader annotation;
  late final FactoryConfig _config;
}