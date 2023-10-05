import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class HomeService {
  late final uriParsed;
  HomeService(String uri) {
    uriParsed = Uri.parse("http://project.chs.ac.th/api/home");
  }
  Future<List<dynamic>> getCourse() async {
    http.Response response =
        await http.get(uriParsed, headers: {"Content-type": "application/json"});
    List<dynamic> jsonRespone = jsonDecode(response.body);
    return jsonRespone;
  }
}
