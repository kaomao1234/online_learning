import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/models/coursedetail_model.dart';
import 'package:online_learning/services/coursedetail_service.dart';

class CourseDetailViewModel {
  late CourseDetailService _courseDetailService;
  CourseDetailViewModel();

  Future<CourseDetailModel> getCourseDetailModel() async {
    int courseId = await SessionManager().get("courseId");
    String username = await SessionManager().get('username');
    _courseDetailService = CourseDetailService(courseId, username);
    Map<String, dynamic> response = await _courseDetailService.getCourse();
    return CourseDetailModel.fromJson(response);
  }

  Future<int> getVideoProgess() async {
    int courseId = await SessionManager().get("courseId"), temp;
    String username = await SessionManager().get('username');
    _courseDetailService = CourseDetailService(courseId, username);
    temp = await _courseDetailService.getVideoProgress();
    return temp;
  }

  void updateLearnProgress(int progress) async {
    int courseId = await SessionManager().get("courseId");
    String username = await SessionManager().get('username');
    _courseDetailService = CourseDetailService(courseId, username);
    _courseDetailService.updateLearnProgress(videoProgress: progress);
  }

  void endrollCourse() async {
    int courseId = await SessionManager().get("courseId");
    String username = await SessionManager().get('username');
    _courseDetailService = CourseDetailService(courseId, username);
    _courseDetailService.enrollCourse();
  }
}
