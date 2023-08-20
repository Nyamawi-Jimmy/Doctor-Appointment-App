import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/Providers/dio_prov.dart';
import 'package:sample/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dimensions/dimensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/jimmy.JPG'),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text(
                              "Jimmy Nyamawi",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.email,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text(
                              "nyamawijimmy@gmail.com",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Icon(Icons.settings,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Icon(Icons.boy,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text(
                              "Gender",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey,),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.logout,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
