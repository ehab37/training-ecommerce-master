import 'package:ecommerce_training/core/controllers/fav_cubit/fav_cubit.dart';
import 'package:ecommerce_training/core/controllers/fav_cubit/fav_states.dart';
import 'package:ecommerce_training/core/controllers/products_controller/product_cubit.dart';
import 'package:ecommerce_training/core/managers/nav.dart';
import 'package:ecommerce_training/models/product_model.dart';
import 'package:ecommerce_training/screens/modules/product_details.dart';
import 'package:ecommerce_training/screens/widgets/build_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavCubit, FavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FavCubit.get(context);
        if (cubit.favModel == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Favorite Products'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite Products'),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.transparent,
                  child: GridView.count(
                    childAspectRatio: 1 / 1.3,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.favModel!.favProducts!.length,
                          (index) => buildProductItem(
                        cubit.favModel!.favProducts![index],
                        context,
                            () {
                              cubit.isFav = true;
                          navigateToNextScreen(
                            context,
                            ProductDetails(
                              product: cubit.favModel!.favProducts![index],
                              // isFav: cubit.isFav,
                            ),
                          );
                        },
                      ),
                    ),
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
