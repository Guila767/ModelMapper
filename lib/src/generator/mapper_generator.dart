import 'dart:ffi';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

class MapperGenerator extends Generator {


  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    print('builder');
    var models = getModelClasses(library.classes);

    return '''
final test = ${models.length};
''';
  }

  List<ClassElement> getModelClasses(Iterable<ClassElement> classes) {
    List<ClassElement> elements = [];
    for (var klass in classes) {
      final klassName = klass.getDisplayString(withNullability: true); 
      final baseName = klass.supertype?.getDisplayString(withNullability: true);

      print('klass $klassName with $baseName');
    }

    return elements;
  }
}