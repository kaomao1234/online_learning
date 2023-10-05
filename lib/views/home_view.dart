import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/models/coursehome_model.dart';
import 'package:online_learning/viewmodels/homeview_model.dart';
import 'package:online_learning/widgets/course_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Map<String, dynamic> items;
  int? _isSelect = 1;
  List<String> categlory = [
    "Test",
    "All",
    "Language Eng",
    "Office word",
    "Office excel",
    "Language Japanese"
  ];
  HomeViewModel _homeViewModel = HomeViewModel();
  @override
  void initState() {
    items = {
      "Profile": () {
        Navigator.pushNamed(context, "/profile_view");
      },
      "Sign out": () {
        setState(() {
          _homeViewModel.signout();
          Navigator.pushNamed(context, "/home_view");
        });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 800),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: Center(
              child: Text(
            "This is not e-learning",
            style: TextStyle(
                fontSize:
                    Theme.of(context).appBarTheme.titleTextStyle?.fontSize,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color),
          )),
          actions: [
            SizedBox(
              width: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return PopupMenuButton(
                          onSelected: (dynamic value) {
                            value();
                          },
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(snapshot.data,
                                style: TextStyle(color: Colors.white)),
                          ),
                          offset: Offset(0, 50),
                          itemBuilder: (context) => items.keys
                              .map((e) => PopupMenuItem(
                                  value: items[e], child: Text(e)))
                              .toList());
                    } else {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login_view");
                          },
                          child: Center(
                            child: Text(
                              "Sign in",
                              style: TextStyle(color: Colors.white),
                            ),
                          ));
                    }
                  },
                  future: SessionManager().get('username'),
                )),
          ],
        ),
        backgroundColor: Colors.white,
        body: Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.only(top: 8),
                child: Column(children: [
                  Text(
                    "Categlogy",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                  StreamBuilder(
                    builder: (context, snapshot) {
                      return Expanded(
                        child: ResponsiveGridList(
                          desiredItemWidth: 150,
                          children: List<Widget>.generate(
                            categlory.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ChoiceChip(
                                selectedColor: Colors.redAccent,
                                selected: _isSelect == index,
                                backgroundColor: Color(0xFF223843),
                                avatar: _isSelect == index
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
                                    _isSelect = selected ? index : _isSelect;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ])),
            Expanded(
              child: FutureBuilder(
                future: _homeViewModel.getAllCourse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    List<dynamic> models =
                        snapshot.data!.where((dynamic element) {
                      if (categlory[_isSelect ?? 1] == element['cat_name']) {
                        return true;
                      } else if (categlory[_isSelect ?? 1] == 'All') {
                        return true;
                      } else {
                        return false;
                      }
                    }).toList();
                    return ResponsiveGridList(
                        desiredItemWidth: 270,
                        children: List.generate(models.length, (index) {
                          CourseHomeModel model =
                              CourseHomeModel.fromJson(models[index]);
                          if (model.catName != categlory[_isSelect ?? 0] &&
                              categlory[_isSelect ?? 0] != 'All') {
                            log(model.cName!);
                          }
                          return Container(
                            padding: EdgeInsets.all(10),
                            height: 380,
                            child: CourseCard(model: model),
                          );
                        }));
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFD77A61),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
