

import 'package:analyzer/dart/element/element.dart';
import 'package:model_mapper/src/internals/template_generators/template_generator.dart';
import 'package:source_gen/source_gen.dart';

class MapperTemplateGenerator extends TemplateGenerator {
  MapperTemplateGenerator(this.modelElement, this.annotation) : super();

  @override
  String generate() {
    final factoryName = '\$${modelElement.name}_ModelFactory';
    addClass(factoryName)
      .withInterface(Type.fromName('IModelFactory<${modelElement.name}>'))
      .withField('IModelBase Function(Map<String, dynamic> map) get fromMap => ${modelElement.name}.fromJson;');
    return super.generate();
  }

  final Element modelElement;
  final ConstantReader annotation;
}