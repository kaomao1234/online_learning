class CourseHomeModel {
  int? courseId;
  String? cName;
  String? cTeacher;
  String? catName;

  CourseHomeModel({this.courseId, this.cName, this.cTeacher, this.catName});

  CourseHomeModel.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    cName = json['c_name'];
    cTeacher = json['c_teacher'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['c_name'] = cName;
    data['c_teacher'] = cTeacher;
    data['cat_name'] = catName;
    return data;
  }
}