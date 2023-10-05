import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginService {
  late final uriParsed;

  LoginService(String uri) {
    uriParsed = Uri.parse(uri);
  }
  Future<dynamic> login(String username, String password) async {
    http.Response response = await http.post(uriParsed,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({"username": username, "password": password}));
    return jsonDecode(response.body);
  }
}
