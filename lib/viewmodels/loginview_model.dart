import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:online_learning/services/login_service.dart';

class LoginViewModel {
  final LoginService _loginService =
      LoginService("http://project.chs.ac.th/api/login");
  LoginViewModel();

  Future<String> onLogin(String username, String password) async {
    dynamic response = await _loginService.login(username, password);
    if (response['loginStatus'] == "Success") {
      setSession(username, password);
      return response['loginStatus'];
    } else {
      return response['message'];
    }
  }

  void setSession(String username, String password) async {
    await SessionManager().set("username", username);
    await SessionManager().set('password', password);
  }
}
