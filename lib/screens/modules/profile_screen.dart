import 'package:ecommerce_training/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_training/core/controllers/profile_cubit/profile_states.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/screens/modules/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        if (cubit.userProfile!.user!.phone == null ||
            cubit.userProfile!.user!.email == null ||
            cubit.userProfile!.user!.name == null ||
            cubit.userProfile!.user!.nationalId == null ||
            cubit.userProfile!.user!.gender == null ||
            cubit.userProfile!.user!.profileImage == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                onPressed: () {
                  navigateToNextScreen(context, UpdateProfileScreen());
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(cubit.userProfile!.user!.profileImage!),
                  ),
                ),
                const SizedBox(height: 35),
                Text(
                  'Name:  ${cubit.userProfile!.user!.name}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'E-mail:  ${cubit.userProfile!.user!.email}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Number:  ${cubit.userProfile!.user!.phone}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'National Id:  ${cubit.userProfile!.user!.nationalId}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Gender:  ${cubit.userProfile!.user!.gender}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
