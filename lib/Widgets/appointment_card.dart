
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({Key? key}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Dimensions.primarycolor,
        borderRadius: BorderRadius.circular(15),
      ),
      child:  Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        "assets/images/jimmy.JPG"
                    ),
                  ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Dr Jimmy Nyamawi",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text("Dental",style: TextStyle(color: Colors.black),),
                      ],
                    )
                ],
              ),
              Dimensions.spacesmall,
              ScheduleWidget(),
              SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent
                        ),
                          onPressed: (){},
                          child: Text("Cancel",style: TextStyle(color: Colors.white),))),
                  SizedBox(width: 10,),
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          ),
                          onPressed: (){},
                          child: Text("Completed",style: TextStyle(color: Colors.white),))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      width: double.maxFinite,
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20,),
          Icon(Icons.calendar_today,color: Colors.white,size: 15,),
          SizedBox(width: 5,),
          Text("Monday 21/04/2023",
            style: TextStyle(
                color: Colors.white
            ),),
          SizedBox(width: 10,),
          Icon(Icons.access_alarm,color: Colors.white,size: 17,),
          SizedBox(width: 5,),
          Flexible(
            child: Text("2:00 PM",
              style: TextStyle(
                  color: Colors.white
              ),),
          ),
        ],
      ),
    );
  }
}