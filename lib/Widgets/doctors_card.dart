import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';

class DoctorsCard extends StatelessWidget {
  final String route;
  const DoctorsCard({Key? key,
    required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      height: 130,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Dimensions.widthsize*0.33,
                child: Image.asset("assets/images/jimmy.JPG"),
              ),
              Flexible(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Dr Jimmy Nyamawi",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                SizedBox(height: 5,),
                Text("Dental",style: TextStyle(color: Colors.black)),
                    const Spacer(),
              Row(
                children: [
                  Icon(Icons.star_border,color: Colors.yellow,size: 16,),
                  Spacer(flex: 1,),
                  Text("4.5"),
                  Spacer(flex: 1,),
                  Text("Reviews"),
                  Spacer(flex: 1,),
                  Text("(20)")
                ],
              )
                  ],
                ),
              ))
            ],
          ),
        ),
        onTap: (){
          Navigator.of(context).pushNamed(route);
        },
      ),
    );
  }
}
