import 'dart:convert';
import 'dart:developer';

import 'package:online_learning/models/user_model.dart';
import "package:http/http.dart" as http;

class RegisterService {
  late final uriParsed;
  RegisterService(String uri) {
    uriParsed = Uri.parse(uri);
  }
  Future<int> create(UserModel model) async {
    http.Response response = await http.post(uriParsed,
        headers: {"Content-type": "application/json"},
        body: jsonEncode(model.toJson));
    return response.statusCode;
  }
}
