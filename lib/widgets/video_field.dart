import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:online_learning/models/videofield_model.dart';
import 'package:online_learning/widgets/chapter_player.dart';

class VideoField extends StatefulWidget {
  int seq;
  Function onDelete;
  VideoFieldModel model;
  VideoField({required this.onDelete, required this.model, this.seq = 1});

  @override
  State<VideoField> createState() => _VideoFieldState();
}

class _VideoFieldState extends State<VideoField> {
  late VideoFieldModel _model;
  bool _isSwitch = false;
  @override
  void initState() {
    _model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Container(
              constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
              child: Row(children: [
                FittedBox(
                    child: Column(
                  children: [
                    Center(
                        child: Text(
                      widget.seq.toString(),
                      style: TextStyle(fontSize: 20),
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () {
                          widget.onDelete();
                        },
                        child: Icon(
                          Icons.remove,
                        )),
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _model.name = value;
                          }
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "The video title should not be empty.";
                          } else {
                            _model.name = value;
                          }
                        },
                        controller:
                            TextEditingController(text: widget.model.name),
                        decoration: InputDecoration(
                            hintText: "video name", border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                      _isSwitch
                          ? ChapterPlayer(
                              onEnded: () {},
                              ytUri: _model.link,
                            )
                          : TextFormField(
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _model.link = value;
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "The video link should not be empty.";
                                } else {
                                  _model.link = value;
                                }
                              },
                              controller: TextEditingController(
                                  text: widget.model.link),
                              decoration: InputDecoration(
                                  hintText: "video link",
                                  border: InputBorder.none),
                              style: TextStyle(
                                fontSize: 21,
                              ),
                            ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("Preview video"),
                    Switch(
                        value: _isSwitch,
                        onChanged: (value) {
                          setState(() {
                            _isSwitch = value;
                          });
                        }),
                  ],
                )
              ]))),
    );
  }
}
