
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample/screens/fav_page.dart';
import 'package:sample/screens/profile_page.dart';

import 'appointment_screen.dart';
import 'home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int _currentPage=0;
  final PageController _page=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _page,
          onPageChanged: ((value){
            setState(() {
              _currentPage=value;
            });
          }),
          children: [
            HomeScreen(),
            FavouritePage(),
            AppointmentPage(),
            ProfilePage()

          ],
        ),
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: _currentPage,
    onTap: (page){
      setState(() {
        _currentPage=page;
        _page.animateToPage(
        page,
    duration: Duration(microseconds: 500),
        curve: Curves.easeInOut
        );
      });
    }, items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
    icon:FaIcon(FontAwesomeIcons.houseChimneyMedical),
    label: "Home"),
      BottomNavigationBarItem(
          icon:FaIcon(FontAwesomeIcons.solidHeart),
          label: "Favourite"),
    BottomNavigationBarItem(
    icon:FaIcon(FontAwesomeIcons.solidCalendarCheck),
    label: "Appointments"),
      BottomNavigationBarItem(
          icon:FaIcon(FontAwesomeIcons.solidUser),
          label: "Profile"),
    ],
    ),
    );
  }
}
