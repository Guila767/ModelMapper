import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/factory_template_generator.dart';
import 'dart:async';

import 'package:source_gen/source_gen.dart';

class FactoryMapperGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  Future<String?> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    
    final lr = LibraryReader(element.library!);
    final modelClasses = await getModelClasses(lr);
    final generator = FactoryTemplateGenerator(element, annotation);
    generator.addModels(modelClasses);

    final source = generator.generate();
    return source;
  }

  Future<List<ClassElement>> getModelClasses(LibraryReader libraryReader) {
    final classes = <ClassElement>[];
    for (var klass in libraryReader.classes) {
      final annotation = klass.metadata.where(
        (element) => element.element?.displayName == 'ModelMapperModel');
      if (annotation.isNotEmpty) {
        classes.add(klass);
      }
    }
    return Future.value(classes);
  }
}