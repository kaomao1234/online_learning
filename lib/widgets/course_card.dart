import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/models/coursehome_model.dart';

class CourseCard extends StatefulWidget {
  late CourseHomeModel model;
  CourseCard({required this.model, super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  late CourseHomeModel _model;
  @override
  void initState() {
    _model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: SizedBox(
        height: 370,
        width: 272,
        child: InkWell(
            splashColor: Colors.black.withAlpha(30),
            onTap: () async {
              if (await SessionManager().get("username") != null) {
                await SessionManager().set("courseId", _model.courseId);
                setState(() {
                  Navigator.pushNamed(context, "/coursedetail_view");
                });
              }
            },
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  width: 272,
                  child: FlutterLogo(
                    size: 150,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: CircleAvatar(
                    minRadius: 20,
                    maxRadius: 20,
                    backgroundImage:
                        AssetImage("assets/images/human_avatar.png"),
                  ),
                  title: Text(
                    _model.cName ?? " ",
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    _model.cTeacher ?? " ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(
                        _model.catName ?? " ",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "start studying",
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
