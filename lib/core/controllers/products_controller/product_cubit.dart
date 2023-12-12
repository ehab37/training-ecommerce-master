import 'package:ecommerce_training/core/controllers/fav_cubit/fav_cubit.dart';
import 'package:ecommerce_training/core/controllers/products_controller/product_states.dart';
import 'package:ecommerce_training/core/network/constant.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());
  static ProductCubit get(context) => BlocProvider.of(context);
  var cubit  = FavCubit();
  LaptopsModel? laptopsModel;
  void getHomeProducts(){
    emit(LoadingFetchProducts());
    DioHelperStore.getData(url:ApiConstants.homeApi).then((value){
      laptopsModel = LaptopsModel.fromJson(value.data);
      print(laptopsModel!.product!.length);
      emit(FetchProducts());
    }).catchError((error){
      print(error.toString());
      emit(ErrorFetchProducts());
    });
  }
}