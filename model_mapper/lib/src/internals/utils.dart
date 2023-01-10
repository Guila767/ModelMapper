import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

extension BuildStepExtensions on BuildStep {
  FutureOr<List<ClassElement>> getClassesWithAnnotation(String className, {Glob? glob}) async {
    final classes = <ClassElement>[];
    final assets = findAssets(glob ?? Glob('**.dart', recursive: true)).asBroadcastStream();
    await for (final asset in assets) {
      if (!await resolver.isLibrary(asset)) {
        continue;
      }
      final library = await resolver.libraryFor(asset);
      final libraryReader = LibraryReader(library);
      for (var klass in libraryReader.classes) {
        final annotation = klass.metadata.where(
          (element) => element.element?.displayName == className);
        if (annotation.isNotEmpty) {
          classes.add(klass);
        }
      }
    }
    return classes;
  }
}