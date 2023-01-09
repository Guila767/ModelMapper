import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/mapper_template_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class ModelMapperGenerator extends GeneratorForAnnotation<ModelMapperModel> {

  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final generator = MapperTemplateGenerator(element, annotation);

    return generator.generate();
  }
}