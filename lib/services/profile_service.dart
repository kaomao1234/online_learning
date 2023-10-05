import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ProfileService {
  dynamic deluriParsed, allCourseUriParsed, historyUriParsed;
  ProfileService();
  void deleteCourse(int courseId) async {
    deluriParsed =
        Uri.parse("http://project.chs.ac.th/api/delcourse/${courseId}");
    http.Response response = await http.post(
      deluriParsed,
      headers: {"Content-type": "application/json"},
    );
  }

  Future<List<dynamic>> getMyCourse(String username) async {
    allCourseUriParsed = Uri.parse("http://project.chs.ac.th/api/myowncourse");
    http.Response response = await http.post(allCourseUriParsed,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({"username": username}));
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getHistory(String username) async {
    historyUriParsed =
        Uri.parse("http://project.chs.ac.th/api/enroll_list?username=${username}");
    http.Response response = await http.get(historyUriParsed);
    return jsonDecode(response.body);
  }
}

// void main(List<String> args) async {
//   ProfileService profileService = ProfileService();
//   dynamic reponse = await profileService.getHistory("admin1234");
//   print(reponse.toString());
//   // profileService.deleteCourse(8);
//   // dynamic reponse2 = await profileService.getMyCourse("oakkharaphop");
//   // print(reponse2.toString());
// }
