

class TokenBuilder {
  
  void writeToken(String token) {
    _buffer.write(token);
    _buffer.write(' ');
  }

  void writeString(String token) {
    _buffer.write('\'');
    _buffer.write(token);
    _buffer.write('\'');
  }

  void writeTokenColonSepareted(String token) {
    _buffer.write(token);
    _buffer.write(', ');
  }

  void writeExpression(String token) {
    _buffer.writeln(token);
  }

  void endLine() {
    _buffer.writeln(';');
  }

  void startObjectBody() {
    _buffer.writeln('{');
  }

  void endObjectBody() {
    _buffer.writeln('}');
  }

  @override
  String toString() => _buffer.toString();

  final _buffer = StringBuffer();
}

abstract class ITemplate {
  void build(TokenBuilder builder);
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

abstract class MethodDefinition implements Type {
  @override
  String get name;
  Type get returnType;
  String get body;
  Iterable<MapEntry<Type, String>> get arguments;
  Iterable<String> get genericsArguments;
}

abstract class ClassDefinition implements Type {
  @override
  String get name;
  ClassDefinition? get superClass;
  Iterable<String> get fields;
  Iterable<Type> get interfaces;
  Iterable<MethodDefinition> get methods;
}

class MethodGenerator implements MethodDefinition, ITemplate {
  MethodGenerator(this.name, this.returnType) {
    _args = <MapEntry<Type, String>>[];
    _generics = <String>[];
  }
  
  @override
  final String name;
  @override
  final Type returnType;
  @override
  String get body => _body;
  @override
  Iterable<MapEntry<Type, String>> get arguments => _args;
  @override
  Iterable<String> get genericsArguments => _generics;
  
  @override
  void build(TokenBuilder builder) {
    builder
      ..writeToken(returnType.name)
      ..writeToken(name);
    if (genericsArguments.isNotEmpty) {
      builder.writeToken('<');
      for (var i = 0; i < genericsArguments.length - 1; i++) {
        builder.writeTokenColonSepareted(genericsArguments.elementAt(i));
      }
      builder
        ..writeToken(genericsArguments.last)
        ..writeToken('>');
    }
    builder.writeToken('(');
    if (arguments.isNotEmpty) {
      for (var i = 0; i < arguments.length - 1; i++) {
        final arg = arguments.elementAt(i);
        builder
          ..writeToken(arg.key.name)
          ..writeTokenColonSepareted(arg.value);
      }
      builder.writeToken(genericsArguments.last);
    }
    builder
      ..writeToken(')')
      ..startObjectBody()
      ..writeExpression(body)
      ..endObjectBody();
  }

  void withBody(String body) => _body = body;

  void withGeneric(String genericAttribute) => _generics.add(genericAttribute);

  void withArgument(Type type, String name) => _args.add(MapEntry(type, name));
  

  factory MethodGenerator.fromDefinition(MethodDefinition def) {
    return MethodGenerator._(def.name, def.returnType, def.body, def.arguments.toList(), def.genericsArguments.toList());
  }

  MethodGenerator._(this.name, this.returnType, this._body, this._args, this._generics);
  late final List<MapEntry<Type, String>> _args;
  late final List<String> _generics;
  late final String _body;
}
  
class ClassGenerator implements ClassDefinition, ITemplate {
  ClassGenerator({required this.name, this.superClass});
  
  @override
  String name;
  @override
  ClassDefinition? superClass;
   @override
  Iterable<String> get fields => _fields;
  @override
  Iterable<Type> get interfaces => _interfaces;
  @override
  Iterable<MethodDefinition> get methods => _methods;
  
  @override
  void build(TokenBuilder builder) {
    builder
      ..writeToken('class')
      ..writeToken(name);
    if (superClass != null) {
      builder
        ..writeToken('extends')
        ..writeToken(superClass!.name);
    }
    if (_interfaces.isNotEmpty) {
      builder.writeToken('implements');
      for (var i = _interfaces.length - 1; i > 0; i--) {
        builder.writeTokenColonSepareted(_interfaces[i].name);
      }
      builder.writeToken(_interfaces[0].name);
    }

    builder.startObjectBody();
    for (var field in fields) {
      builder.writeExpression(field);
    }
    for (var method in methods) {
      MethodGenerator mg;
      if (methods is MethodGenerator) {
        mg = methods as MethodGenerator;
      } else {
        mg = MethodGenerator.fromDefinition(method);
      }
      mg.build(builder);
    }
    builder.endObjectBody();
  }

  ClassGenerator withMethod(MethodDefinition definition) {
    _methods.add(definition);
    return this;
  }

  ClassGenerator withInterface(Type type) {
    _interfaces.add(type);
    return this;
  }

  ClassGenerator withField(String field) {
    _fields.add(field);
    return this;
  }
  
  MethodGenerator addMethod(String name, Type returnType) {
    final mg = MethodGenerator(name, returnType);
    _methods.add(mg);
    return mg;
  }

  final List<Type> _interfaces = <Type>[];
  final List<MethodDefinition> _methods = <MethodDefinition>[];
  final List<String> _fields = <String>[];
}
 
class TemplateGenerator {
  final builder = TokenBuilder();

  String generate() {

    for (var import in _imports) {
      builder
        ..writeToken('import')
        ..writeString(import)
        ..endLine();
    }
    for (var declaration in _topLevelDeclarations) {
      builder
        .writeExpression(declaration);
    }
    for (var method in _methods) {
      MethodGenerator mg;
      if (method is MethodGenerator) {
        mg = method;
      } else {
        mg = MethodGenerator.fromDefinition(method);
      }
      mg.build(builder);
    }
    for (var klass in _classes) {
      ClassGenerator cg = klass as ClassGenerator;
      cg.build(builder);
    }
    return builder.toString();
  }

  ClassGenerator addClass(String name) {
    final cg = ClassGenerator(name: name);
    _classes.add(cg);
    return cg;
  }

  MethodGenerator addMethod(String name, Type returnType) {
    final mg = MethodGenerator(name, returnType);
    _methods.add(mg);
    return mg;
  }

  TemplateGenerator withImport(String path) {
    _imports.add(path);
    return this;
  }

  TemplateGenerator withTopLevelDeclaration(String declarion) {
    _topLevelDeclarations.add(declarion);
    return this;
  }

  final _imports = <String>[];
  final _methods = <MethodDefinition>[];
  final _classes = <ClassDefinition>[];
  final _topLevelDeclarations = <String>[];
}