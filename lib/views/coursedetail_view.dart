import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:online_learning/viewmodels/coursedetailview_model.dart';
import 'package:online_learning/widgets/chapter_player.dart';

import '../models/coursedetail_model.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({super.key});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  final CourseDetailViewModel _courseDetailViewModel = CourseDetailViewModel();
  late List<bool> _isExpandeds, _isCompletes, _isUnlocks;
  late List<IconData> _iconDatas;
  late List<MaterialColor> _colors;
  bool _isSet = false;
  int videoProgress = 1;
  @override
  void initState() {
    getVideoProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _courseDetailViewModel.getCourseDetailModel(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return viewCourse(snapshot.data!);
          } else {
            log("hello");
            return const Center(
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget viewCourse(CourseDetailModel model) {
    int cVideoLen = model.cVideo!.keys.length;
    if (_isSet != true) {
      _isExpandeds = List.generate(cVideoLen, (index) => false);
      _isCompletes = List.generate(cVideoLen, (index) {
        return index < videoProgress - 2 ? true : false;
      });
      _isUnlocks = List.generate(
          cVideoLen, (index) => index < videoProgress - 1 ? true : false);
      _colors = List.generate(cVideoLen, (index) => Colors.red);
      _iconDatas = List.generate(cVideoLen, (index) => Icons.lock);
    }
    _isSet = true;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
        leading: Center(
            child: Text(
          model.cName!,
          style: TextStyle(
              fontSize: Theme.of(context).appBarTheme.titleTextStyle?.fontSize,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        )),
      ),
      body: Container(
        constraints: BoxConstraints(minWidth: 640),
        child: ListView(padding: EdgeInsets.all(20), children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              model.cName!,
              style: TextStyle(fontSize: 24, color: Color(0xFF223843)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Teacher: ${model.cTeacher!}",
              style: TextStyle(fontSize: 18, color: Color(0xFFD8B4A0)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text(
                "Description",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(model.cDescription!),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.all(8),
              elevation: 3,
              expansionCallback: ((panelIndex, isExpanded) {
                if (_isUnlocks[panelIndex] == true) {
                  setState(() {
                    _isExpandeds[panelIndex] = !_isExpandeds[panelIndex];
                  });
                }
              }),
              children: List.generate(
                  cVideoLen,
                  (index) => ExpansionPanel(
                      isExpanded: _isExpandeds[index],
                      headerBuilder: (context, isExpanded) => ListTile(
                            title: ListTile(
                              title: Text(model.cVideo!.keys.elementAt(index)),
                              trailing: Icon(
                                onIcon(index),
                                color: onColor(index),
                              ),
                            ),
                          ),
                      body: ListTile(
                        title: _isExpandeds[index]
                            ? index - 1 >= 0
                                ? _isCompletes[index - 1]
                                    ? ChapterPlayer(
                                        onEnded: () {
                                          setState(() {
                                            _isCompletes[index] = true;
                                            if (index + 1 < cVideoLen) {
                                              _isUnlocks[index + 1] = true;
                                            }
                                          });
                                        },
                                        ytUri: model.cVideo!.values
                                            .elementAt(index),
                                      )
                                    : null
                                : ChapterPlayer(
                                    onEnded: () {
                                      setState(() {
                                        _isCompletes[index] = true;
                                        if (index + 1 < cVideoLen) {
                                          _courseDetailViewModel
                                              .updateLearnProgress(
                                                  videoProgress + 1);
                                          getVideoProgress();
                                          _isSet = false;
                                        }
                                      });
                                    },
                                    ytUri:
                                        model.cVideo!.values.elementAt(index))
                            : null,
                      ))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.3,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: Size(0, 50)),
                  onPressed: () async {
                    setState(() {
                      if (videoProgress == 1) {
                        _courseDetailViewModel.endrollCourse();
                        _courseDetailViewModel
                            .updateLearnProgress(videoProgress + 1);

                        _isSet = false;
                      } else {
                        _isExpandeds.asMap().forEach((key, value) {
                          if (key == videoProgress - 2) {
                            _isExpandeds[key] = true;
                          } else {
                            _isExpandeds[key] = false;
                          }
                        });
                      }
                    });
                    getVideoProgress();
                  },
                  child: Text(videoProgress > 1
                      ? "go back to class"
                      : "start studying")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.3,
              child: TextButton(
                  onPressed:
                      _isCompletes.every((element) => element ? true : false)
                          ? null
                          : () {},
                  child: const Text("Show certificate")),
            ),
          )
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }

  void getVideoProgress() async {
    videoProgress = await _courseDetailViewModel.getVideoProgess();
  }

  IconData onIcon(int index) {
    if (_isUnlocks[index] == false) {
      _iconDatas[index] = Icons.lock;
    } else if (_isUnlocks[index]) {
      _iconDatas[index] = Icons.lock_open;
      if (_isCompletes[index]) {
        _iconDatas[index] = Icons.check;
      }
    }
    return _iconDatas[index];
  }

  MaterialColor onColor(int index) {
    if (_isUnlocks[index] == false) {
      _colors[index] = Colors.red;
    } else if (_isUnlocks[index]) {
      _colors[index] = Colors.amber;
      if (_isCompletes[index]) {
        _colors[index] = Colors.green;
      }
    }

    return _colors[index];
  }
}
