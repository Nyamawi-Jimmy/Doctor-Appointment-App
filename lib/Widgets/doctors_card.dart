import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/main.dart';
import 'package:sample/screens/doctor_details.dart';

import '../Dimensions/dimensions.dart';
class DoctorsCard extends StatelessWidget {
  final Map <String,dynamic>doctor;
  final bool isFav;
  const DoctorsCard({Key? key,
    required this.doctor, required this.isFav}) : super(key: key);

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
                child: Image.asset('assets/images/jimmy.JPG')
                //Image.network("https://gambo.rickieyngambo.xyz/appointment/api/appointment${doctor["doctor_profile"]}"),
              ),
              Flexible(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Dr ${doctor['doctor_name']}",style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
                SizedBox(height: 5,),
                Text("${doctor['category']}",style: TextStyle(color: Colors.black)),
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
          //Navigator.of(context).pushNamed(route,arguments: doctor);
          MyApp.navigatorkey.currentState!.push(MaterialPageRoute(builder: (_)=>DoctorDetails(
            doctor: doctor,
          isFav:isFav
          )));
        },
      ),
    );
  }
}
