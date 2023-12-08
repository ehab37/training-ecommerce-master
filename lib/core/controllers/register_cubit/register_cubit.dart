import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ecommerce_training/core/controllers/register_cubit/register_states.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  void userRegister({required name,required email,required phone,required nationalId,required password}){
   emit(LoadingRegister());
    DioHelperStore.postData(url:ApiConstants.registerApi, data:{
      "name":name,
      "email":email,
      "phone": phone,
      "nationalId":nationalId,
      "gender":'male',
      "password":password,
      "profileImage":userImage,
    }).then((value){
      userModel = UserModel.fromJson(value.data);
      print(userModel!.user!.name!);
      emit(RegisterDone(userModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorRegister());
    });
  }ImagePicker picker = ImagePicker();
  File? image;
  Uint8List? bytes;
  String? userImage;
  Future<void> addImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      bytes = File(image!.path).readAsBytesSync();
      userImage = base64Encode(bytes!);
      print('images = $userImage');
      emit(ChooseImage());
    } else {
      print('no image selected');
    }
  }
}