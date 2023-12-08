import 'package:ecommerce_training/models/user_model.dart';

abstract class RegisterStates{}
class RegisterInitState extends RegisterStates{}
class LoadingRegister extends RegisterStates{}
class RegisterDone extends RegisterStates{
  final UserModel userModel;
  RegisterDone(this.userModel);
}
class ErrorRegister extends RegisterStates{}
class ChooseImage extends RegisterStates{}

