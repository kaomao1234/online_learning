import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/models/addcourse_model.dart';
import 'package:online_learning/models/videofield_model.dart';
import 'package:online_learning/services/addcourse_service.dart';

class AddCourseViewModel {
  List<VideoFieldModel> videofieldLst = [];
  late String cName, cDescription, catName;
  final AddCourseService _addCourseService = AddCourseService();
  late Map<String, String> videofieldMap;
  void sendCourse() async {
    String username = await SessionManager().get("username");
    AddCourseModel model = AddCourseModel(
        username: username,
        cName: cName,
        catName: catName,
        cVideo: {for (var ele in videofieldLst) ele.name: ele.link},
        cDescription: cDescription);
    _addCourseService.addCourse(model);
  }

  void addVideoField() {
    VideoFieldModel temp = VideoFieldModel("", "");
    for (int i = 0; i <= videofieldLst.length; i++) {
      temp.seq = i;
    }
    videofieldLst.add(temp);
  }

  void deleteVideoField(int index) {
    videofieldLst.removeAt(index);
    for (int i = 0; i < videofieldLst.length; i++) {
      videofieldLst[i].seq = i;
    }
  }
}
