import 'dart:async';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:model_mapper/model_mapper.dart';
import 'package:model_mapper/src/internals/template_generators/factory_template_generator.dart';
import 'package:model_mapper/src/internals/utils.dart';

class FactoryMapperGenerator extends GeneratorForAnnotation<ModelMapperFactory> {
  
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    
    final config = _parseConfigFromAnnotation(element, annotation);
    var modelClasses = await _getModelClasses(buildStep);
    if (await element.isUnitTest(buildStep)) {
      modelClasses = modelClasses
        .where((klass) => klass.library == element.library)
        .toList();
    }

    for (var model in modelClasses.where((klass) => klass.isGeneric)) {
      if (model.typeParameters.length > 1) {
        throw Exception('Uncapable of generating a factory for multiple type parameters on \'${model.name}\'');
      }
      final type = model.typeParameters.first;
      final bound = type.bound;
      if (bound is! InterfaceType) {
        throw Exception('The type parameter \'${type.name}\' on \'${model.name}\' must have a bound to an \'IModelBase\'');
      }
      if (bound.element.displayName != 'IModelBase' &&
          !bound.allSupertypes.any(
              (element) => element.element.displayName == 'IModelBase')) {
        throw Exception('The type parameter \'${type.name}\' on \'${model.name}\' must have a bound to an \'IModelBase\'');
      }
    }

    final generator = FactoryTemplateGenerator(element.name!, config);
    generator.addModels(modelClasses);
    return generator.generate();
  }

  FutureOr<List<ClassElement>> _getModelClasses(BuildStep buildStep) => 
    buildStep.getClassesWithAnnotation('ModelMapperModel');

  FactoryConfig _parseConfigFromAnnotation(Element element, ConstantReader annotation) {
    final configObj = annotation.read('config').objectValue;
    final configReader = ConstantReader(configObj);
    var objEntries = (configObj.type as InterfaceType).accessors
      .where((element) => 
        !element.isStatic && element.isGetter && element.isPublic)
      .map((e) {
        final field = configReader.read(e.name);
        Object? value;
        if (field.isLiteral) {
          value = field.literalValue;
        } else if (field.isBool) {
          value = field.boolValue;
        } else if (field.isMap) {
          value = field.mapValue;
        } else if (field.objectValue.variable != null) {
          value = field.objectValue.variable!.name;
        }
        return MapEntry(e.name, value);
      });
    return FactoryConfig.fromMap(Map.fromEntries(objEntries));
  }
}