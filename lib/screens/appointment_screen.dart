import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

List<dynamic> schedules = [
  {
    "doctor_name": "Dr Jimmy Nyamawi",
    "doctor_profile": "assets/images/jimmy.JPG",
    "category": "Dental",
    "status": FilterStatus.upcoming
  },
  {
    "doctor_name": "Dr Erick Wanjohi",
    "doctor_profile": "assets/images/jimmy.JPG",
    "category": "Cardiology",
    "status": FilterStatus.complete
  },
  {
    "doctor_name": "Dr Morris Wanjohi",
    "doctor_profile": "assets/images/jimmy.JPG",
    "category": "Respirations",
    "status": FilterStatus.complete
  },
  {
    "doctor_name": "Dr Carlos Daff",
    "doctor_profile": "assets/images/jimmy.JPG",
    "category": "Dermatology",
    "status": FilterStatus.cancel
  }
];

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> filteredSchedules = schedules.where((schedule) => schedule["status"] == FilterStatus.upcoming).toList();

  @override
  Widget build(BuildContext context) {
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
                      var _schedule=filteredSchedules[index];
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
                                        _schedule["doctor_profile"]
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _schedule["doctor_name"],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          _schedule["category"],
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
                              ScheduleWidget(),
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
  const ScheduleWidget({Key? key}) : super(key: key);

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
          Text("Monday 21/04/2023",
            style: TextStyle(
                color:  Dimensions.primarycolor
            ),),
          SizedBox(width: 10,),
          Icon(Icons.access_alarm,color: Dimensions.primarycolor,size: 17,),
          SizedBox(width: 5,),
          Flexible(
            child: Text("2:00 PM",
              style: TextStyle(
                 color: Dimensions.primarycolor
              ),),
          ),
        ],
      ),
    );
  }
}
