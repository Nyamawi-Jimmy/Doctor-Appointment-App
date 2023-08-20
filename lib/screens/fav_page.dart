import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/Widgets/doctors_card.dart';
import 'package:sample/models/auth_model.dart';
import 'package:sample/screens/doctor_details.dart';

import '../Dimensions/dimensions.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: EdgeInsets.only(top: 20,left: 20,right: 20),
      child: Column(
        children: [
          Text("My Favourite Doctors",textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.bold,
                fontSize: 18
          ),),
          SizedBox(height: 20),
          Expanded(child: Consumer<AuthModel>(
            builder: (context,auth,child){
              return   ListView.builder(
              itemCount: auth.getFavDoc.length,
              itemBuilder: (context, index){
              return DoctorsCard(
                  isFav:true,
                  //route: "doc_details",
                  doctor: auth.getFavDoc[index]);
              });
            },

          )
          ),
        ],
      )
    )
    );
  }
}
