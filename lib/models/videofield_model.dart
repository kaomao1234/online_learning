class VideoFieldModel {
  String name, link;
  late int seq;
  VideoFieldModel(this.name, this.link);
  Map<String, String> get toMap => {name: link};
}
