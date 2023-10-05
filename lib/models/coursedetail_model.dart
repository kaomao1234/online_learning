import 'dart:convert';

class CourseDetailModel {
  int? courseId;
  String? cName;
  String? catName;
  String? cDescription;
  String? cTeacher;
  Map<String, dynamic>? cVideo;

  CourseDetailModel(
      {this.courseId,
      this.cName,
      this.catName,
      this.cDescription,
      this.cTeacher,
      this.cVideo});

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    cName = json['c_name'];
    catName = json['cat_name'];
    cDescription = json['c_description'];
    cTeacher = json['c_teacher'];
    cVideo = jsonDecode(json['c_video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['c_name'] = cName;
    data['cat_name'] = catName;
    data['c_description'] = cDescription;
    data['c_teacher'] = cTeacher;
    data['c_video'] = cVideo;
    return data;
  }
}
