import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/services/profile_service.dart';

class ProfileViewModel {
  final ProfileService _profileService = ProfileService();

  Future<dynamic> getHistory() async {
    return await _profileService.getHistory(await getUsername());
  }

  void deleteCourse(int courseId) async {
    _profileService.deleteCourse(courseId);
  }

  Future<List<dynamic>> getUserCourse() async {
    return await _profileService.getMyCourse(await getUsername());
  }

  Future<String> getUsername() async {
    return await SessionManager().get('username');
  }

  void signOut() async {
    await SessionManager().remove('username');
  }
}
