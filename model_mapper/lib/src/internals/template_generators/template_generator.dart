
abstract class ITemplate {
  String build();
}

abstract class Type {
  String get name;
  factory Type.fromName(String name) => TypeRef(name);
}

class TypeRef implements Type {
  final String _typeRefName;
  TypeRef(this._typeRefName);
  @override
  String get name =>_typeRefName;
}

class DartType implements Type {
  final String _typeName;

  const DartType._(this._typeName);

  @override
  String get name => _typeName;

  static const DartType intType = DartType._('int');
  static const DartType classType = DartType._('class');
}

abstract class MethodDefinition {
  String get name;
  Type get returnType;
  String get body;
  final List<Type> _args = [];
}

abstract class ClassDefinition {
  String get name;
  ClassDefinition? get superClass;
  final List<String> _fields = <String>[];
  final List<ClassDefinition> _interfaces = <ClassDefinition>[];
  final List<MethodDefinition> _methods = <MethodDefinition>[];
}

class ClassGenerator implements ITemplate {
  
  @override
  String build() {
    throw UnimplementedError();
  }

}

abstract class TemplateGenerator {

}