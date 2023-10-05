import 'dart:convert';
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:online_learning/models/addcourse_model.dart';

class AddCourseService {
  final uriParsed = Uri.parse("http://project.chs.ac.th/api/addcourse");
  AddCourseService();
  void addCourse(AddCourseModel model) async {
    final uri = Uri.parse(
        "http://project.chs.ac.th/api/addcourse?username=${model.username}&c_name=${model.cName}&cat_name=${model.catName}&c_description=${model.cDescription}&c_video=${jsonEncode(model.cVideo)}");
    http.Response response = await http.get(
      uri,
      headers: {"Content-type": "application/json"},
    );
    log(jsonDecode(response.body).toString());
    log(response.statusCode.toString());
  }
}
