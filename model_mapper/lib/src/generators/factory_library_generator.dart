
import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'dart:async';
import 'package:build/build.dart';
import 'package:model_mapper/src/internals/template_generators/template_generator.dart';
import 'package:model_mapper/src/internals/utils.dart';
import 'package:model_mapper/src/model_mapper_base.dart';
import 'package:path/path.dart' as Path;

import 'package:source_gen/source_gen.dart';

class FactoryLibraryGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final path = Path.Context(style: Path.Style.posix);
    final paths = HashSet<String>();
    final models = await getModelClasses(buildStep);
    for (final model in models) {
      var modelAsset = await buildStep.resolver.assetIdForElement(model);
      paths.add(
        path.join('package:${modelAsset.package}', path.joinAll(modelAsset.pathSegments.skip(1)))
      );
    }
    final tb = TokenBuilder();
    for (final path in paths) {
      tb
        ..writeToken('export')
        ..writeString(path)
        ..endLine();
    }
    return tb.toString();
  }
  
  static FutureOr<List<ClassElement>> getModelClasses(BuildStep buildStep) => 
    buildStep.getClassesWithAnnotation('ModelMapperModel');
    
}