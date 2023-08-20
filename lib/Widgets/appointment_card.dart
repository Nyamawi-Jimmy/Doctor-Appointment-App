
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:sample/Providers/dio_prov.dart';
import 'package:sample/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dimensions/dimensions.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({Key? key, required this.doctor, required this.color}) : super(key: key);

 final Map <String,dynamic> doctor;
 final Color color;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: widget.color,
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
                    backgroundImage:/* NetworkImage(
                        "https://gambo.rickieyngambo.xyz/appointment/api/appointment${widget.doctor["doctor_profile"]}"),*/
                    AssetImage('assets/images/jimmy.JPG')
                  ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text("Dr ${widget.doctor["doctor_name"]}",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                        SizedBox(height: 5,),
                        Text(widget.doctor["category"],style: TextStyle(color: Colors.black),),
                      ],
                    )
                ],
              ),
              Dimensions.spacesmall,
              ScheduleWidget(
                appointment: widget.doctor['appointments'],
              ),
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
                          onPressed: (){
                            showDialog(context: context, builder: (context){
                              return RatingDialog(
                                initialRating: 1.0,
                                  title: const Text('Rate the doctor',textAlign: TextAlign.center,
                                    style:TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  message: Text('Please help us rate our doctor',textAlign: TextAlign.center,
                                    style:TextStyle(fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  image: const FlutterLogo(size: 100,),
                                  submitButtonText: 'Submit',
                                  commentHint: "Your Reviews",
                                  onSubmitted: (response)async{
                                  final SharedPreferences prefs=await SharedPreferences.getInstance();
                                  final token=prefs.getString('token');
                                  final rating=await DioProvider().storeReviews(response.comment,
                                      response.rating,
                                      widget.doctor['appointments']['id'],
                                      widget.doctor['doc_id'], token!);

                                  if(rating==200 && rating!=''){
                                    MyApp.navigatorkey.currentState!.pushNamed("main");
                                  }
                                  });
                            });
                          },
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
  const ScheduleWidget({Key? key, required this.appointment}) : super(key: key);
  final Map <String,dynamic> appointment;


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
          Text("${appointment['day']}, ${appointment['date']}",
            style: TextStyle(
                color: Colors.white
            ),),
          SizedBox(width: 10,),
          Icon(Icons.access_alarm,color: Colors.white,size: 17,),
          SizedBox(width: 5,),
          Flexible(
            child: Text(appointment['time'],
              style: TextStyle(
                  color: Colors.white
              ),),
          ),
        ],
      ),
    );
  }
}