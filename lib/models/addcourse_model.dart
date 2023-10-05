import 'dart:convert';

class AddCourseModel {
  late String username, cName, catName, cDescription;
  late Map<String, dynamic> cVideo;
  AddCourseModel(
      {required this.username,
      required this.cName,
      required this.catName,
      required this.cVideo,
      required this.cDescription});

  AddCourseModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    cName = json['c_name'];
    catName = json['cat_name'];
    cDescription = json['c_desription'];
    cVideo = jsonDecode(json['c_video']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['c_name'] = cName;
    data['cat_name'] = catName;
    data['c_desription'] = cDescription;
    data['c_video'] = cVideo;
    return data;
  }
}
