import 'package:ecommerce_training/models/user_model.dart';

abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoadingLogin extends LoginStates {}

class LoginDone extends LoginStates {
  final UserModel userModel;
  LoginDone(this.userModel);
}

class ErrorLogin extends LoginStates {}
