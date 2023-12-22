import 'package:ecommerce_training/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_training/core/controllers/profile_cubit/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        nameController.text = cubit.userProfile!.user!.name!;
        emailController.text = cubit.userProfile!.user!.email!;
        numberController.text = cubit.userProfile!.user!.phone!;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Update your profile"),
            actions: [
              IconButton(
                onPressed: () {
                  cubit.updateProfile(email: emailController.text,name: nameController.text,phone: numberController.text,);
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.check,
                  size: 40,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: buildOutlineInputBorder(),
                    enabledBorder: buildOutlineInputBorder(),
                    focusedBorder: buildOutlineInputBorder(),
                    labelText: "Name",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: buildOutlineInputBorder(),
                    enabledBorder: buildOutlineInputBorder(),
                    focusedBorder: buildOutlineInputBorder(),
                    labelText: "E-mail",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                    border: buildOutlineInputBorder(),
                    enabledBorder: buildOutlineInputBorder(),
                    focusedBorder: buildOutlineInputBorder(),
                    labelText: "Phone Number",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 2,
        ),
      );
}
