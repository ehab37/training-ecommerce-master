import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void userLogin({required email, required password}) {
    emit(LoadingLogin());
    DioHelperStore.postData(url: ApiConstants.loginApi, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(LoginDone(userModel!));
    }).catchError((error) {
      emit(ErrorLogin());
    });
  }
}
