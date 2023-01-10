
import 'dart:convert';

import 'package:example/api_client.dart';
import 'package:example/models/factory/sample_factory.factory_library.g.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() async {

  final client = createMockClient();
  final api = ApiClient(client);

  final sample = await api.get<SampleModel>('sample');
  final person = await api.get<PersonModel>('person');
  print(sample.message);
  print('Hello ${person.name}, you birthday is ${person.birthday.toIso8601String()} and you have ${person.age} years');
}

BaseClient createMockClient() => MockClient(
  (request) async {
    if (request.url.path == '/person') {
      return Response(
        jsonEncode(PersonModel("guila", 21, DateTime.parse('2001-03-16')).toMap()),
        200,
        headers: {'content-type': 'application/json'}
      );
    } else if (request.url.path == '/sample') {
      return Response(
        jsonEncode(SampleModel("Hello, world!").toMap()),
        200,
        headers: {'content-type': 'application/json'}
      );
    }
    return Response("", 404);
  }
);
