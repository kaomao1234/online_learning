import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:online_learning/models/videofield_model.dart';
import 'package:online_learning/viewmodels/addcourseview_model.dart';
import 'package:online_learning/widgets/video_field.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../models/addcourse_model.dart';

class AddCourseView extends StatefulWidget {
  const AddCourseView({super.key});

  @override
  State<AddCourseView> createState() => _AddCourseViewState();
}

class _AddCourseViewState extends State<AddCourseView> {
  AddCourseViewModel _addCourseViewModel = AddCourseViewModel();
  final _formKey = GlobalKey<FormState>();
  late List<Widget> children;
  late TextEditingController cName, cdescription;
  int? _value = 1;
  List<String> categlory = [
    "Language Eng",
    "Office word",
    "Office excel",
    "Language Japanese",
    "Test"
  ];
  @override
  void initState() {
    cName = TextEditingController();
    cdescription = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cName.dispose();
    cdescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addCourseViewModel.catName = categlory[_value ?? 0];
    children = initListView();
    children.insert(
      0,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
            categlory.length,
            (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    selectedColor: Colors.redAccent,
                    selected: _value == index,
                    backgroundColor: Color(0xFF223843),
                    avatar: _value == index
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                    label: Text(
                      "${categlory[index]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : _value;
                        _addCourseViewModel.catName =
                            categlory[_value ?? index];
                      });
                    },
                  ),
                )),
      ),
    );
    children.addAll(List<VideoField>.generate(
        _addCourseViewModel.videofieldLst.length,
        (index) => VideoField(
            seq: index + 1,
            onDelete: () {
              setState(() {
                _addCourseViewModel.videofieldLst.removeAt(index);
              });
            },
            model: _addCourseViewModel.videofieldLst[index])));
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
        leading: TextButton(
          onPressed: () =>
              Navigator.pushReplacementNamed(context, "/home_view"),
          child: Text(
            "This is not e-learning",
            style: TextStyle(
                fontSize:
                    Theme.of(context).appBarTheme.titleTextStyle?.fontSize,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            constraints: BoxConstraints(minWidth: 640),
            child: ListView(
              padding: EdgeInsets.only(bottom: 40, top: 20),
              children: children,
            )),
      ),
      backgroundColor: Colors.white,
      bottomSheet: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton.icon(
            onPressed: () {
              setState(() {
                _addCourseViewModel.addVideoField();
              });
            },
            icon: Icon(Icons.text_fields),
            label:
                SizedBox(height: 40, child: Center(child: Text("Add video")))),
        ElevatedButton.icon(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _addCourseViewModel.sendCourse();
                Navigator.pushReplacementNamed(context, "/home_view");
              }
            },
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            label: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }

  List<Widget> initListView() {
    return [
      Center(
        child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 25, right: 25),
            child: Container(
                constraints: BoxConstraints(minWidth: 300, maxWidth: 800),
                child: TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Course name should not be empty.";
                    } else {
                      _addCourseViewModel.cName = value;
                    }
                  }),
                  controller: cName,
                  style: TextStyle(fontSize: 35),
                  decoration: InputDecoration(
                      hintText: "Course Name",
                      hintStyle: TextStyle(fontSize: 35),
                      border: InputBorder.none),
                ))),
      ),
      Center(
        child: Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 25, right: 25),
            child: Container(
                constraints: BoxConstraints(minWidth: 300, maxWidth: 800),
                child: TextFormField(
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Description should not be empty.";
                    } else {
                      _addCourseViewModel.cDescription = value;
                    }
                  }),
                  controller: cdescription,
                  style: TextStyle(fontSize: 35),
                  decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: TextStyle(fontSize: 35),
                      border: InputBorder.none),
                ))),
      ),
    ];
  }
}
