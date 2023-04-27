 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/button.dart';

class AppointmentBooked extends StatelessWidget {
   const AppointmentBooked({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SafeArea(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Expanded(
              flex: 1,
                child: Lottie.asset("assets/images/success.json"),
            ),
             Container(
               width: double.infinity,
               alignment: Alignment.center,
               child: Text("Successfully Booked.",style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 20,
                 color: Colors.green
               ),),
             ),
             const Spacer(),
             Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              child: Button(
                width: double.infinity,
                title: "Back to Home Page",
                onPressed: ()=>Navigator.of(context).pushNamed("main"),
                disable: false,
              ),
             )

           ],
         ),
       ),
     );
   }
 }
