import 'package:ecommerce_training/models/onboarding.dart';
import 'package:flutter/material.dart';

Widget buildOnBoardingItem(OnBoardingModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Container(

        height: 250,

        child: Image(image: AssetImage(model.image!),),

      ),

      SizedBox(

        height: 10,

      ),

      Text(model.title!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 40),),

      SizedBox(

        height: 10,

      ),

      Text(model.subtitle!,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),

    ],

  ),
);