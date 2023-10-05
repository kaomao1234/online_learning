import 'dart:developer';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/services/home_service.dart';

class HomeViewModel {
  HomeService _homeService = HomeService("http://project.chs.ac.th/api/home");
  HomeViewModel();
  void setCourseinToSession(String courseName) async {
    await SessionManager().set("clickCourse", courseName);
  }

  Future<List<dynamic>> getAllCourse() async {
    final courses = await _homeService.getCourse();
    return courses;
  }

  Future<dynamic> userIsLogin() async {
    return await SessionManager().get("username");
  }

  void signout() async {
    await SessionManager().remove('username');
  }
}
