import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel? userProfile;

  void getUserProfile() {
    emit(LoadingProfile());
    DioHelperStore.postData(
      url: ApiConstants.profileApi,
      data: {"token": token},
    ).then((value) {
      userProfile = UserModel.fromJson(value.data);
      print(userProfile!.user!.name!);
      emit(ProfileDone());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorProfile());
    });
  }

  void updateProfile({
    name,
    email,
    phone,
  }) {
    DioHelperStore.putData(
      url: ApiConstants.updateProfileApi,
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "gender": 'male',
        "password": "12345678",
        "token": token,
      },
    ).then((value) {
      userProfile = UserModel.fromJson(value.data);
      print(userProfile!.user!.name!);
      getUserProfile();
      emit(UpdateProfileDone());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateProfile());
    });
  }
}
