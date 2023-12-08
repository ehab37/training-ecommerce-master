import 'package:ecommerce_training/core/controllers/register_cubit/register_cubit.dart';
import 'package:ecommerce_training/core/controllers/register_cubit/register_states.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/local/cache_helper.dart';
import 'package:ecommerce_training/screens/modules/login.dart';
import 'package:ecommerce_training/screens/widgets/botton.dart';
import 'package:ecommerce_training/screens/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RegisterScreen extends StatelessWidget{
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nationalController = TextEditingController();
  RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(listener:(context,state) {
      if (state is RegisterDone) {
        if (state.userModel.status == "success") {
          print(state.userModel.message);
          //showToast(state.userModel.message!, ToastStates.SUCCESS);
          print(state.userModel.user!.token);
          CacheHelper.saveData(
              key: 'userId', value: state.userModel.user!.nationalId)
              .then((value) {
            natoinalId = state.userModel.user!.nationalId;
          });
          CacheHelper.saveData(
            key: 'token',
            value: state.userModel.user!.token,
          ).then((value) {
            token = state.userModel.user!.token!;
            navigateAndFinishThisScreen(
              context,
              const LoginScreen(),
            );
          });
        } else {
          print(state.userModel.message);
        }
      }
    },
      builder:(context,state){
      var cubit = RegisterCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Register',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
              Padding(
                padding: const EdgeInsets.only(left: 40, bottom: 100),
                child: cubit.image == null
                    ? MaterialButton(
                    onPressed: () {
                      cubit.addImage();
                    },
                    child: CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.bing.com/th?id=OIP.UL-1DMfhVszKjcYlgEespAD0D_&w=159&h=185&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )))
                    : CircleAvatar(
                  radius: 40,
                  child: ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(cubit.image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DefaultFieldForm(
                controller: nameController,
                keyboard: TextInputType.text,
                valid: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Your Name';
                  }
                  return null;
                },
                labelStyle:const TextStyle(color:Colors.black),
                label: 'Full Name',
                prefix: Icons.person,
                hint: 'Full Name',
                hintStyle: const TextStyle(color: Colors.grey),
                show: false,
              ),
              const SizedBox(
                height: 15,
              ),
              DefaultFieldForm(
                labelStyle: TextStyle(color:Colors.black),
                controller: emailController,
                keyboard: TextInputType.emailAddress,
                valid: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter your Email';
                  }
                  return null;
                },
                label: 'Email Address',
                prefix: Icons.email,
                hint: 'Email Address',
                hintStyle: const TextStyle(color: Colors.grey),
                show: false,
              ),
              const SizedBox(
                height: 15,
              ),
              DefaultFieldForm(
                labelStyle: TextStyle(color:Colors.black),
                controller: phoneController,
                keyboard: TextInputType.phone,
                label: 'Phone',
                valid: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Your Phone';
                  }
                  return null;
                },
                prefix: Icons.phone,
                hint: 'Phone',
                hintStyle: const TextStyle(color: Colors.grey),
                show: false,
              ),
              const SizedBox(
                height: 15,
              ),
              DefaultFieldForm(
                  labelStyle: TextStyle(color:Colors.black),
                  controller: passwordController,
                  keyboard: TextInputType.visiblePassword,
                  valid: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  label: 'Password',
                  prefix: Icons.password,
                  hint: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                show: false,
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              DefaultFieldForm(
                labelStyle: const TextStyle(color:Colors.black),
                controller: nationalController,
                keyboard: TextInputType.number,
                label: 'National ID',
                valid: (value) {
                  if (value.isEmpty) {
                    return 'Please Confirm Your National Id';
                  }
                  return null;
                },
                prefix: Icons.video_stable,
                hint: 'National ID',
                hintStyle: const TextStyle(color: Colors.grey),
                show: false,
              ),
              SizedBox(
                height: 10,
              ),
              DefaultButton(
                  backgroundColor:Colors.black,
                  borderColor: Colors.transparent,
                  buttonWidget: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  function: () {
                    if (formKey.currentState!.validate()) {
                              cubit.userRegister(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                                nationalId: nationalController.text,
                              );
                            }
                  }),
        ],
      ),
          ),
      ),
      );
      },);
  }
}
