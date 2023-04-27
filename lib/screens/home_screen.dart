
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Dimensions/dimensions.dart';
import '../Widgets/appointment_card.dart';
import '../Widgets/doctors_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Map<String, dynamic>> medCart=[
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"General"
    },
    {
      "icon":FontAwesomeIcons.heartPulse,
      "category":"Cardiology"
    },
    {
      "icon":FontAwesomeIcons.lungs,
      "category":"Respirations"
    },
    {
      "icon":FontAwesomeIcons.hands,
      "category":"Dermatology"
    },
    {
      "icon":FontAwesomeIcons.personPregnant,
      "category":"Gynecology"
    },
    {
    "icon":FontAwesomeIcons.teeth,
    "category":"Dentist"
    }
  ];
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nyamawi",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        "assets/images/jimmy.JPG"
                      ),
                    )
                  ],
                ),
                Dimensions.spacesmall,
                Text("Categories",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                Dimensions.spacesmall,
                SizedBox(
                  height:  Dimensions.heightsize*0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(medCart.length, (index) => Card(
                        margin: EdgeInsets.only(right: 10),
                      color: Dimensions.primarycolor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FaIcon(medCart[index]["icon"],color: Colors.white,),
                            const SizedBox(width: 10,),
                            Text(medCart[index]["category"],style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white

                            ),),
                          ],
                        ),
                      ),
                      ))

                  ),
                ),
                Dimensions.spacesmall,
                Text("Appointment Today",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                Dimensions.spacesmall,
                AppointmentCard(),
                Dimensions.spacesmall,
                Text("Top Doctors",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                Dimensions.spacesmall,
                Column(
                  children: List.generate(10, (index) => DoctorsCard(
                    route: 'doc_details',
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



