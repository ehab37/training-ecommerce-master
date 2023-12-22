import 'package:ecommerce_training/core/controllers/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_training/core/controllers/fav_cubit/fav_cubit.dart';
import 'package:ecommerce_training/core/controllers/onboarding_cubit/onboarding_cubit.dart';
import 'package:ecommerce_training/core/controllers/products_controller/product_cubit.dart';
import 'package:ecommerce_training/core/controllers/profile_cubit/profile_cubit.dart';
import 'package:ecommerce_training/core/controllers/register_cubit/register_cubit.dart';
import 'package:ecommerce_training/core/managers/values.dart';
import 'package:ecommerce_training/core/network/local/cache_helper.dart';
import 'package:ecommerce_training/core/network/remote/dio_helper.dart';
import 'package:ecommerce_training/screens/modules/login.dart';
import 'package:ecommerce_training/screens/modules/onboarding.dart';
import 'package:ecommerce_training/screens/modules/prducts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/controllers/login_cubit/login_cubit.dart';
import 'core/controllers/observer.dart';
import 'core/managers/themes.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelperStore.init();
  await CacheHelper.init();
  var boarding = CacheHelper.getData(key: 'Boarding');
  token = CacheHelper.getData(key:'token');
  natoinalId = CacheHelper.getData(key:'userId');
  if(boarding==true){
    if(token!=null) {
      nextScreen = const ProductScreen();
    }else{
      nextScreen = const LoginScreen();
    }
  }else{
    nextScreen =const OnboardingScreen();
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => OnBoardingCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => CartCubit()..getCart(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => ProfileCubit()..getUserProfile(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => FavCubit()..getFav(),
        lazy: false,
      ),
      BlocProvider(
        create: (context) => RegisterCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => LoginCubit(),
        lazy: true,
      ),
      BlocProvider(
        create: (context) => ProductCubit()..getHomeProducts(),
        lazy: false,
      ),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:lightTheme,
        home:nextScreen,
      ),
    );
  }
}
