import 'package:online_learning/models/user_model.dart';
import 'package:online_learning/services/register_service.dart';

class RegisterViewModel {
  String uri = "http://project.chs.ac.th/api/register";
  late RegisterService _registerService;
  RegisterViewModel() {
    _registerService = RegisterService(uri);
  }
  Future<int> createAccount(UserModel model) async {
    return await _registerService.create(model);
  }
}
