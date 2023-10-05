import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/viewmodels/loginview_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  TextEditingController username = TextEditingController(),
      password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  final LoginViewModel _loginViewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 100,
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
        body: Align(
          alignment: Alignment.topCenter,
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  constraints: BoxConstraints(maxWidth: 400, maxHeight: 500),
                  child: ListView(
                    padding: EdgeInsets.only(left: 30, top: 40, right: 30),
                    children: [
                      Center(
                        child: Text(
                          "Log in to your account",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          controller: username,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Username',
                          )),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: isObscure,
                        controller: password,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              icon: Icon(isObscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            )),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String status = await _loginViewModel.onLogin(
                                  username.text, password.text);
                              if (status == 'Success') {
                                Navigator.pushReplacementNamed(
                                    context, "/home_view");
                              } else {
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(status),
                                    duration: Duration(seconds: 1),
                                  ));
                                });
                              }
                            }
                          },
                          child: Center(child: Text("Log in"))),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 40,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register_view');
                            },
                            child: Text("Create account")),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
