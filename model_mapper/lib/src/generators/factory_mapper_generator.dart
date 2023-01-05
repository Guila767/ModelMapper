import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'dart:async';

import 'package:source_gen/source_gen.dart';

class FactoryMapperGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  Future<String?> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    
    final lr = LibraryReader(element.library!);
    final modelClasses = getModelClasses(lr);

    return '';
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