
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/models/auth_model.dart';
import 'package:sample/screens/booking_page.dart';
import 'package:sample/screens/doctor_details.dart';
import 'package:sample/screens/home_screen.dart';
import 'package:sample/screens/main%20_layout.dart';
import 'package:sample/screens/profile_page.dart';
import 'package:sample/screens/success_booked.dart';

import 'Authentication/auth_page.dart';
import 'Authentication/login_form.dart';
import 'Dimensions/dimensions.dart';

void main() {
  runApp(MyApp(),
    );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final navigatorkey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context)=>AuthModel(),
      child: MaterialApp(
        navigatorKey: MyApp.navigatorkey,
        debugShowCheckedModeBanner: false,
        title: 'Doctor Appointment',
        theme: ThemeData(
//pre-defined input decoration
            inputDecorationTheme: const InputDecorationTheme(
              border: Dimensions.outlineborder,
              focusColor: Dimensions.primarycolor,
              focusedBorder: Dimensions.focusborder,
              errorBorder: Dimensions.errorborder,
              floatingLabelStyle: TextStyle(color:Dimensions.primarycolor),
              prefixIconColor: Colors.black,
            ),
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme:BottomNavigationBarThemeData(
                backgroundColor:Dimensions.primarycolor,
                selectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey.shade700,
                elevation: 10,
                type: BottomNavigationBarType.fixed
            )
        ),

        initialRoute: "/",
        routes: {

          //initial page.Login page
          "/":(context)=> AuthPage(),
          //main page after login
          "main":(context)=>const MainLayout(),
          //"home":(context)=>HomeScreen(),
          //"doc_details":(context)=>const DoctorDetails(),
          "booking_page":(context)=>const BookingPage(),
          "appointment_booked":(context)=>const AppointmentBooked(),


        },
      ),
    );
  }
}
