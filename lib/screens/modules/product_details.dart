import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_training/core/controllers/fav_cubit/fav_cubit.dart';
import 'package:ecommerce_training/core/controllers/fav_cubit/fav_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product, });

  final product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavCubit, FavStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = FavCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 32,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              !cubit.isFav
                                  ? cubit.addToFav(context, product.sId)
                                  : cubit.deleteFav(context, product.sId);
                            },
                            icon: Icon(
                              cubit.isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              size: 32,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.7,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: AspectRatio(
                                aspectRatio: 1.7,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: product.images[cubit.imagesIndex].toString(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error_outline),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            product.name.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          product.description.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: null,
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${product.price}\$',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: null,
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black26),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  product.status.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    // DetailsListView(images: product.images),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              cubit.isSelected(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: AspectRatio(
                                    aspectRatio: 1.7,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: product.images![index].toString(),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error_outline),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
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
