import 'package:ecommerce_training/core/controllers/fav_cubit/fav_states.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/fav_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitState());

  static FavCubit get(context) => BlocProvider.of(context);
  PostDeleteFavModel? postDeleteFavModel;
  bool isFav= false;
  int imagesIndex = 0;
  void isSelected(index){
    imagesIndex = index;
    emit(IsSelectedImage());
  }
  void getFavIcon(context) {
    if (postDeleteFavModel!.message == 'Product added to favorites') {
      ScaffoldMessenger.of(context).clearSnackBars();
      isFav= true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            postDeleteFavModel!.message.toString(),
          ),
        ),
      );
    } else if (postDeleteFavModel!.message == 'Product already added') {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            postDeleteFavModel!.message.toString(),
          ),
        ),
      );
    } else if (postDeleteFavModel!.message ==
        'Product removed from favorites') {
      ScaffoldMessenger.of(context).clearSnackBars();
      isFav= false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            postDeleteFavModel!.message.toString(),
          ),
        ),
      );
    } else if (postDeleteFavModel!.message ==
        'Product not found in favorites') {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            postDeleteFavModel!.message.toString(),
          ),
        ),
      );
    }
  }

  void addToFav(context,productId) {
    DioHelperStore.postData(
        url: ApiConstants.favApi,
        data: {"nationalId": natoinalId, "productId": productId}).then((value) {
      postDeleteFavModel = PostDeleteFavModel.fromJson(value.data);
      isFav= true;
      emit(AddToFav());
      getFavIcon(context);
      getFav();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorAddToFav());
    });
  }

  FavModel? favModel;

  void getFav() {
    DioHelperStore.getData(url: ApiConstants.favApi, data: {
      "nationalId": natoinalId,
    }).then((value) {
      favModel = FavModel.fromJson(value.data);
      print(favModel!.favProducts!.length);
      emit(GetFav());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFav());
    });
  }

  void deleteFav(context,productId) {
    DioHelperStore.delData(url: ApiConstants.favApi, data: {
      "nationalId": natoinalId,
      "productId": productId,
    }).then((value) {
      postDeleteFavModel = PostDeleteFavModel.fromJson(value.data);
      isFav = false;
      emit(DeleteFav());
      getFavIcon(context);
      getFav();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteFav());
    });
  }
}
