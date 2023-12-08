import 'package:ecommerce_training/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_training/core/controllers/cart_cubit/cart_states.dart';
import 'package:ecommerce_training/screens/widgets/build_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widgets/botton.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CartCubit.get(context);
          if (cubit.cartModel == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: Colors.grey[200],
                title: const Text('Cart'),
                centerTitle: true,
              ),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    if (cubit.cartModel!.products!.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildCartItem(
                              cubit.cartModel!.products![index], context),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 30,
                              ),
                          itemCount: cubit.cartModel!.products!.length),
                    if (cubit.cartModel!.products!.isEmpty)
                      const Center(
                        child: Text('Cart Is Empty'),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: HexColor('#FEFEFE'),
                            borderRadius: BorderRadius.circular(6)),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('Apply coppen code .....'),
                              const Spacer(),
                              DefaultButton(
                                  height: 40,
                                  backgroundColor: HexColor('#07094D'),
                                  width: 93,
                                  buttonWidget: const Text(
                                    'Apply',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  function: () {}),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ]))));
        });
  }
}
