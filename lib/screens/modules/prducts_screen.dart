import 'package:ecommerce_training/core/controllers/fav_cubit/fav_cubit.dart';
import 'package:ecommerce_training/core/controllers/products_controller/product_cubit.dart';
import 'package:ecommerce_training/core/controllers/products_controller/product_states.dart';
import 'package:ecommerce_training/models/fav_model.dart';
import 'package:ecommerce_training/screens/modules/cart.dart';
import 'package:ecommerce_training/screens/modules/favorite.dart';
import 'package:ecommerce_training/screens/modules/product_details.dart';
import 'package:ecommerce_training/screens/widgets/build_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/managers/nav.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        if (cubit.laptopsModel == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Cart'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    navigateToNextScreen(context, CartScreen());
                  },
                ),
                ListTile(
                  title: const Text('Favorite'),
                  leading: const Icon(Icons.favorite),
                  onTap: () {
                    navigateToNextScreen(context, const FavoriteScreen());
                  },
                ),
              ],
            ),
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
                      cubit.laptopsModel!.product!.length,
                      (index) => buildProductItem(
                        cubit.laptopsModel!.product![index],
                        context,
                        () {
                          var cubit2 = FavCubit.get(context);
                          for (FavProduct favProduct
                              in cubit2.favModel!.favProducts!) {
                            if (cubit.laptopsModel!.product![index].sId ==
                                favProduct.sId) {
                              cubit2.isFav = true;
                            }else{
                              cubit2.isFav= false;
                            }
                          }
                          cubit2.imagesIndex = 0;
                          navigateToNextScreen(
                            context,
                            ProductDetails(
                              product: cubit.laptopsModel!.product![index],
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
