import 'package:flutter/material.dart';
import 'package:online_learning/views/addcourse_view.dart';
import 'package:online_learning/views/coursedetail_view.dart';
import 'package:online_learning/views/home_view.dart';
import 'package:online_learning/views/login_view.dart';
import 'package:online_learning/views/profile_view.dart';
import 'package:online_learning/views/register_view.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
              constraints: BoxConstraints(minHeight: 50)),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xFF223843)),
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.all(8),
              errorStyle: TextStyle(fontSize: 12, height: 0),
              suffixIconColor: Color(0xFF223843),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF223843))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF223843)))),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                  foregroundColor: Colors.black)),
          iconTheme: const IconThemeData(color: Color(0xFF223843)),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            toolbarTextStyle: TextStyle(fontSize: 20),
            titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFFD77A61)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  disabledBackgroundColor: const Color(0xFFD77A61),
                  backgroundColor: const Color(0xFFD77A61),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))))),
      initialRoute: "/home_view",
      routes: {
        "/register_view": (context) => const RegisterView(),
        "/home_view": (context) => const HomeView(),
        '/login_view': (context) => const LoginView(),
        "/profile_view": (context) => const ProfileView(),
        "/coursedetail_view": (context) => const CourseDetailView(),
        '/addcourse_view': (context) => const AddCourseView()
      },
    );
  }
}
