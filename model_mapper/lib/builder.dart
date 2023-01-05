library model_mapper.builder;

import 'package:build/build.dart';
import 'package:model_mapper/src/generators/factory_mapper_generator.dart';
import 'package:model_mapper/src/generators/model_mapper_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder modelMapperBuilder(BuilderOptions options) => 
  SharedPartBuilder(
    [ModelMapperGenerator(), FactoryMapperGenerator()],
    'model_mapper'
  );