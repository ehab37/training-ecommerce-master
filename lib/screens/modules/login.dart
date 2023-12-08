import 'package:ecommerce_training/core/controllers/login_cubit/login_cubit.dart';
import 'package:ecommerce_training/core/controllers/login_cubit/login_states.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/local/cache_helper.dart';
import 'package:ecommerce_training/screens/modules/prducts_screen.dart';
import 'package:ecommerce_training/screens/modules/register.dart';
import 'package:ecommerce_training/screens/widgets/botton.dart';
import 'package:ecommerce_training/screens/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginDone) {
          if (state.userModel.status == "success") {
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
                const ProductScreen(),
              );
            });
          } else {
            print(state.userModel.message);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    DefaultFieldForm(
                      controller: emailController,
                      keyboard: TextInputType.emailAddress,
                      valid: (value){
                        if(value.isEmpty){
                          return 'Please Confirm Your E-mail';
                        }
                        return null;
                      },
                      hint: 'Enter your e-mail',
                      prefix: Icons.email_outlined,
                    ),
                    const SizedBox(height: 25),
                    DefaultFieldForm(
                      controller: passwordController,
                      keyboard: TextInputType.emailAddress,
                      valid: (value){
                        if(value.isEmpty){
                          return 'Please Confirm Your Password';
                        }
                        return null;
                      },
                      hint: 'Enter password',
                      prefix: Icons.visibility_off_outlined,
                      show: true,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultButton(
                        backgroundColor: Colors.black,
                        borderColor: Colors.transparent,
                        buttonWidget: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Don't have account?",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
