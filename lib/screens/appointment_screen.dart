import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/Providers/dio_prov.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dimensions/dimensions.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }


class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  Future <void> getAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    print(token);
    final appointment=await DioProvider().getAppointment(token);
    print('yeeeii');
    if(appointment!='error'){
      print('yeeeii');
      setState((){
        schedules=json.decode(appointment);
        print(schedules);
      });
    }else{
      print('noooo');

    }
  }

  @override
  void initState(){
    getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
          switch (schedule['status']){
            case 'upcoming':
              schedule['status']=FilterStatus.upcoming;
                  break;
            case 'complete':
              schedule['status']=FilterStatus.complete;
              break;
            case 'cancel':
              schedule['status']=FilterStatus.cancel;
              break;
          }
        return schedule["status"] == status;}).toList();
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Appointment Schedule",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
              Dimensions.spacesmall,
             Stack(
               children: [
                 Container(
                   width: double.infinity,
                   height: 40,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                     color: Colors.white
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       for( FilterStatus filterStatus in FilterStatus.values)
                         Expanded(
                             child: GestureDetector(
                               onTap: () {
                                 setState(() {
                                   if (filterStatus == FilterStatus.upcoming) {
                                     status = FilterStatus.upcoming;
                                     _alignment = Alignment.centerLeft;
                                   } else if (filterStatus == FilterStatus.complete) {
                                     status = FilterStatus.complete;
                                     _alignment = Alignment.center;
                                    // print("complete tapped");
                                   } else if (filterStatus == FilterStatus.cancel) {
                                     status = FilterStatus.cancel;
                                     _alignment = Alignment.centerRight;
                                     //print("cancel tapped");
                                   }

                                   // Update the filteredSchedules list based on the updated status
                                   filteredSchedules = schedules.where((schedule) => schedule["status"] == status).toList();
                                 });
                               },
                               child: Center(
                                 child: Text(filterStatus.name),
                               ),
                             ),)
                     ],
                   ),
                 ),
                 AnimatedAlign(
                     alignment: _alignment,
                     duration: Duration(milliseconds: 200),
                   child: Container(
                     width: 100,
                     height: 40,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: Dimensions.primarycolor
                     ),
                     child: Center(
                       child: Text(
                         status.name,
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold
                         ),
                       ),
                     ),
                   ),

                 ),

               ],
             ),
              Dimensions.spacesmall,
              Expanded(
                  child: ListView.builder(
                    itemCount: filteredSchedules.length,
                    itemBuilder: (context,index){
                      var schedule=filteredSchedules[index];
                      bool isLastElement=filteredSchedules.length +1 ==index;
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.grey
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: !isLastElement? EdgeInsets.only(bottom: 20):EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                       'assets/images/jimmy.JPG'
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schedule["doctor_name"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          schedule["category"],
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              SizedBox(height: 5,),
                              ScheduleWidget(
                                date: schedule['date'],
                                day: schedule['day'],
                                time: schedule['time'],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                      child: OutlinedButton(
                                          onPressed: (){},
                                          child: Text("Cancel",style: TextStyle(color: Dimensions.primarycolor),))),
                                  SizedBox(width: 10,),
                                  Expanded(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Dimensions.primarycolor
                                          ),
                                          onPressed: (){},
                                          child: Text("Reschedule",style: TextStyle(color: Colors.white),))),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        )
    );
  }
}

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({Key? key, required this.date, required this.day, required this.time}) : super(key: key);
  final String date;
  final String day;
  final String time;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade300
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 20,),
          Icon(Icons.calendar_today,color: Dimensions.primarycolor,size: 15,),
          SizedBox(width: 5,),
          Text('$day,$date',
            style: TextStyle(
                color:  Dimensions.primarycolor
            ),),
          SizedBox(width: 10,),
          Icon(Icons.access_alarm,color: Dimensions.primarycolor,size: 17,),
          SizedBox(width: 5,),
          Flexible(
            child: Text("$time",
              style: TextStyle(
                 color: Dimensions.primarycolor
              ),),
          ),
        ],
      ),
    );
  }
}
