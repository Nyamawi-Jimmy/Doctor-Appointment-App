import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:sample/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dimensions/dimensions.dart';
import '../Providers/dio_prov.dart';
import '../Widgets/appointment_card.dart';
import '../Widgets/doctors_card.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    Map<String, dynamic>user={};
    List<dynamic> favList=[];
    Map<String, dynamic>doctor={};
  List<Map<String, dynamic>> medCart = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiology"},
    {"icon": FontAwesomeIcons.lungs, "category": "Respirations"},
    {"icon": FontAwesomeIcons.hands, "category": "Dermatology"},
    {"icon": FontAwesomeIcons.personPregnant, "category": "Gynecology"},
    {"icon": FontAwesomeIcons.teeth, "category": "Dentist"}
  ];

   /* Future <void> getData() async{

    //Get token from sharedp references
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token=prefs.getString('token')??'';

    if(token.isNotEmpty && token !=''){
      //Get userdata
      final response = await DioProvider().getUser(token);
      if(response!=null){
        setState(() {
          user = json.decode(response);
          //print(user);
          //check todays appointment if there is any return for today
          for(var doctorData in user ['doctor']){
            //if there is any pass for today and then the doctor info
            if(doctorData['appointments']!=null){
              doctor=doctorData;
              print(doctor);
            }
          }
        });
      }
    }
  }

    @override
    void initState(){
      getData();
      super.initState();
    }*/

  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    user=Provider.of<AuthModel>(context,listen: false).getUser;
    doctor=Provider.of<AuthModel>(context,listen: false).getAppointment;
    favList=Provider.of<AuthModel>(context,listen: false).getFav;

    print('user data is : $user');
    print('fav list data is : $favList');

    return Scaffold(
      body: user.isEmpty?
          Center(
            child: CircularProgressIndicator(),
          )
      :Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user['name'] ?? 'User',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/jimmy.JPG"),
                        )
                      ],
                    ),
                    Dimensions.spacesmall,
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Dimensions.spacesmall,
                    SizedBox(
                      height: Dimensions.heightsize * 0.05,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              medCart.length,
                              (index) => Card(
                                    margin: EdgeInsets.only(right: 10),
                                    color: Dimensions.primarycolor,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FaIcon(
                                            medCart[index]["icon"],
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            medCart[index]["category"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))),
                    ),
                    Dimensions.spacesmall,
                    Text(
                      "Appointment Today",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Dimensions.spacesmall,
                    doctor.isNotEmpty?AppointmentCard(
                      doctor: doctor,color: Dimensions.primarycolor,
                    ):Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Padding (padding: EdgeInsets.all(20),
                        child: Text('No Appointments Today',style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),),
                        ),

                      ),
                    ),
                    Dimensions.spacesmall,
                    Text(
                      "Top Doctors",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Dimensions.spacesmall,
                    Column(
                      children: List.generate(
                        user['doctor'].length,
                        (index) => DoctorsCard(
                          //route: 'doc_details',
                          doctor:user['doctor'][index],
                          isFav:favList.contains(user['doctor'][index]['doc_id'])? true:false
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
    );
  }
}

