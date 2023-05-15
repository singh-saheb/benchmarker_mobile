import 'dart:convert';

import 'package:major_benchmark_app/model/component_model.dart';
import 'package:http/http.dart' as http;

String url =
    "https://ap-south-1.aws.data.mongodb-api.com/app/data-nmdro/endpoint/data/v1/action/find";

Map<String, String> headers = {
  'Content-Type': 'application/json',
  'Access-Control-Request-Headers': '*',
  'api-key': "m7eqi2mZtgilBvg0VVyDjkbXPYVSphZrb9xJB8TnyvXR5TULnoawVQoZFdKTQ94q",
};

class NetworkUtil {
  Future<List<Component>> getData(String collectionName) async {
    String payload = json.encode({
      "collection": collectionName,
      "database": "test",
      "dataSource": "Cluster0",
    });

    final res = await http.post(
      Uri.parse(url),
      body: payload,
      headers: headers,
    );
    List data = json.decode(res.body)["documents"];
    return data.map((e) => Component.fromJson(e)).toList();
  }
}
