import 'dart:developer';

import 'package:date_field/date_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:online_learning/models/user_model.dart';

import '../viewmodels/registerview_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewdtate();
}

class _RegisterViewdtate extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController(),
      email = TextEditingController(),
      passwd = TextEditingController(),
      username = TextEditingController();
  DateTime? date;
  bool isLoading = false;
  RegisterViewModel _RegisterViewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        automaticallyImplyLeading: false,
        title: TextButton(
          child: Text(
            "This is not e-learning",
            style: TextStyle(
                fontSize:
                    Theme.of(context).appBarTheme.titleTextStyle?.fontSize,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color),
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/home_view");
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: ListView(
                children: [
                  Center(
                      child: Text(
                    "Create account",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                        hintText: 'Fullname'),
                    validator: (String? text) {
                      if (text!.isEmpty) {
                        return "Please enter your fullname";
                        return "";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email'),
                    validator: (String? text) {
                      if (EmailValidator.validate(text ?? "")) {
                      } else {
                        return "Please enter a valid email address.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        hintText: 'Username'),
                    validator: (String? text) {
                      if (text!.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwd,
                    decoration: InputDecoration(
                        hintText: 'Password'),
                    validator: (String? text) {
                      if (passwd.text.length < 8) {
                        return "be at least 8 characters long";
                      } else if (text!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Birthday',
                    ),
                    initialEntryMode: DatePickerEntryMode.inputOnly,
                    dateFormat: DateFormat('dd-MM-yyyy'),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (DateTime? value) {
                      if (value != null &&
                          value.year != DateTime.now().year) {
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
                  Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Color(0xFFD77A61),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                // NEW
                              ),
                              onPressed: () {
                                setState(() {
                                  onPress();
                                });
                              },
                              child: SizedBox(child: Text("Create account")),
                            ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPress() async {
    if (_formKey.currentState!.validate() && date != null) {
      isLoading = true;
      int result = await _RegisterViewModel.createAccount(UserModel.fromJson(
          username: username.text,
          email: email.text,
          password: passwd.text,
          fullname: fullname.text,
          birthdate: date.toString()));
      if (result == 200) {
        isLoading = false;
        Navigator.pushReplacementNamed(context, "/home_view");
      }
    }
  }
}
