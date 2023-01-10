import 'dart:async';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/factory_template_generator.dart';
import 'package:model_mapper/src/internals/utils.dart';

class FactoryMapperGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final modelClasses = await getModelClasses(buildStep);
    final generator = FactoryTemplateGenerator(element, annotation);
    generator.addModels(modelClasses);
    return generator.generate();
  }

  FutureOr<List<ClassElement>> getModelClasses(BuildStep buildStep) => 
    buildStep.getClassesWithAnnotation('ModelMapperModel');
}