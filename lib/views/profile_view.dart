import 'dart:convert';
import 'dart:developer';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:intl/intl.dart';
import 'package:online_learning/models/coursedetail_model.dart';
import 'package:online_learning/viewmodels/profileview_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Map<String, dynamic> items;
  DateTime? date;
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  @override
  void initState() {
    items = {
      "Sign out": () {
        setState(() {
          _profileViewModel.signOut();
          Navigator.pushNamed(context, "/home_view");
        });
      }
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          actions: [
            SizedBox(
              width: 20,
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: FutureBuilder(
                  future: _profileViewModel.getUsername(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return PopupMenuButton(
                          onSelected: (dynamic value) {
                            value();
                          },
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text(snapshot.data!,
                                style: TextStyle(color: Colors.white)),
                          ),
                          offset: Offset(0, 50),
                          itemBuilder: (context) => items.keys
                              .map((e) => PopupMenuItem(
                                  value: items[e], child: Text(e)))
                              .toList());
                    } else {
                      return CircularProgressIndicator(
                        color: Color(0xFFD77A61),
                      );
                    }
                  }),
                ))
          ],
        ),
        body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                    color: Colors.white,
                    child: SafeArea(
                        child: Column(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 30,
                              width: 400,
                              child: TabBar(
                                  labelColor: Color(0xFF223843),
                                  indicatorColor: Color(0xFF223843),
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Center(
                                      child: Text(
                                        "Courses",
                                        style: TextStyle(),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "My learning",
                                        style: TextStyle(),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ))),
              ),
              body: ColoredBox(
                color: Colors.white,
                child: TabBarView(children: [courses(), myLearning()]),
              ),
            )));
  }

  Widget courses() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 200,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: () {
                  Navigator.pushNamed(context, "/addcourse_view");
                },
                child: Center(child: Text("Add coruse"))),
          ),
          Expanded(
            child: FutureBuilder(
                future: _profileViewModel.getUserCourse(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    log(snapshot.data.toString());
                    return Container(
                      constraints: BoxConstraints(maxWidth: 700),
                      child: ListView(
                        padding: EdgeInsets.all(8),
                        children: List.generate(snapshot.data!.length, (index) {
                          return Card(
                            child: InkWell(
                              onTap: () async {
                                await SessionManager().set("courseId",
                                    snapshot.data![index]['course_id']);
                                setState(() {
                                  Navigator.pushNamed(
                                      context, "/coursedetail_view");
                                });
                              },
                              splashColor: Colors.black.withAlpha(30),
                              child: ListTile(
                                onTap: null,
                                title: Text(snapshot.data![index]['c_name']),
                                subtitle:
                                    Text(snapshot.data![index]['cat_name']),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _profileViewModel.deleteCourse(
                                          snapshot.data![index]['course_id']);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("You don't have your course."),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget myLearning() {
    return Container(
        child: FutureBuilder(
            future: _profileViewModel.getHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                log(snapshot.data.toString());
                return Container(
                  constraints: BoxConstraints(maxWidth: 700),
                  child: ListView(
                    padding: EdgeInsets.all(8),
                    children: List.generate(snapshot.data!.length, (index) {
                      return Card(
                        child: InkWell(
                          onTap: () async {
                            await SessionManager().set(
                                "courseId", snapshot.data![index]['course_id']);
                            setState(() {
                              Navigator.pushNamed(
                                  context, "/coursedetail_view");
                            });
                          },
                          splashColor: Colors.black.withAlpha(30),
                          child: ListTile(
                            onTap: null,
                            title: Text(snapshot.data![index]['c_name']),
                            subtitle: Text(snapshot.data![index]['cat_name']),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              } else {
                return Center(
                  child: Text("You don't have your course."),
                );
              }
            }));
  }

  Widget basicInfo() {
    return Align(
      alignment: Alignment.center,
      child: Form(
        child: Container(
          constraints: BoxConstraints(maxWidth: 450),
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Fullname",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 10,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Birthday',
                ),
                initialEntryMode: DatePickerEntryMode.inputOnly,
                dateFormat: DateFormat('dd-MM-yyyy'),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (DateTime? value) {
                  if (value != null && value.year != DateTime.now().year) {
                    date = value;
                  } else {
                    return 'Please not the this year';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "Biology",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () {
                    setState(() {});
                  },
                  child: Center(child: Text("Save")))
            ],
          ),
        ),
      ),
    );
  }
}
