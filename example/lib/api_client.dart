
import 'dart:convert';
import 'dart:io';

import 'package:example/models/factory/sample_factory.dart';
import 'package:http/http.dart';
import 'package:model_mapper/model_mapper.dart';

class ApiClient {
  ApiClient(this.client);
  final BaseClient client;

  static const host = 'localhost';

  Future<T> get<T extends IModelBase>(String uri) async {
    final request = await client.get(Uri(host: host, path: uri));
    final json = jsonDecode(request.body);
    return _factory.get<T>().fromMap(json) as T;
  }

  SampleFactory get _factory => SampleFactory();
}