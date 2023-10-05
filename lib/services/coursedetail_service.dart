import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class CourseDetailService {
  late final uriParsed;
  late String username;
  late int courseId;
  late dynamic enrollUriparsed;
  CourseDetailService(this.courseId, this.username) {
    uriParsed = Uri.parse("http://project.chs.ac.th/api/course/$courseId");
  }
  Future<Map<String, dynamic>> getCourse() async {
    http.Response response = await http.get(uriParsed);
    dynamic jsonRespone = jsonDecode(response.body);
    return jsonRespone;
  }

  Future<int> getVideoProgress() async {
    final uri =
        Uri.parse("http://project.chs.ac.th/api/video_progress/${courseId}");
    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "username": username,
        }));
    return jsonDecode(response.body);
  }

  void updateLearnProgress({int videoProgress = 0}) async {
    final uri = Uri.parse(
        "http://project.chs.ac.th/api/video_enroll_update/${courseId}/${videoProgress.toString()}");
    http.Response response = await http.post(uri,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "username": username,
        }));
  }

  void enrollCourse() async {
    enrollUriparsed = Uri.parse("http://project.chs.ac.th/api/enroll");
    http.Response response = await http.post(enrollUriparsed,
        headers: {"Content-type": "application/json"},
        body: jsonEncode({
          "username": username,
          'course_id': courseId,
          'is_complete': false
        }));
  }
}
