import 'dart:async';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/factory_template_generator.dart';

class FactoryMapperGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    
    final lr = LibraryReader(element.library!);
    final modelClasses = getModelClasses(lr);
    final generator = FactoryTemplateGenerator(element, annotation);
    generator.addModels(modelClasses);
    return generator.generate();
  }

  List<ClassElement> getModelClasses(LibraryReader libraryReader) {
    final classes = <ClassElement>[];
    for (var klass in libraryReader.classes) {
      final annotation = klass.metadata.where(
        (element) => element.element?.displayName == 'ModelMapperModel');
      if (annotation.isNotEmpty) {
        classes.add(klass);
      }
    }
    return classes;
  }
}