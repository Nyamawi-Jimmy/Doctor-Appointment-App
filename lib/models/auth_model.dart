import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Authentication/user.dart';


class AuthModel extends ChangeNotifier {
  bool _isLogIn = false;
   Map <String,dynamic> user={};//update user details when logging in
     Map <String,dynamic> appointment={};//update all incoming appointments
  List <Map <String,dynamic>> favDoc=[];// get all  latest favourite doctors
  List <dynamic> _fav=[];   //get all favourite doctor id in list



  bool get isLogin{
    return _isLogIn;
  }

  List <dynamic> get getFav{
    return _fav;
  }

  Map <String,dynamic> get getUser{
    return user;
  }

  Map <String,dynamic> get getAppointment{
    return appointment;
  }
//This is to update all the latest favourite and notify all the other widgets
  void setFavList(List <dynamic> list){
    _fav=list;
        notifyListeners();
  }

  //This is to return latest favourite doctor list
  List <Map <String,dynamic>> get getFavDoc{
    favDoc.clear();//get all previous list before getting latest list
    //list out favourite doctors according to fav list
    for(var num in _fav){
      for(var doc in user['doctor']){
        if(num==doc['doc_id']){
          favDoc.add(doc);
        }
      }
    }
    return favDoc;
  }

  void loginSuccess(
  Map <String,dynamic> userData, Map <String,dynamic>appointmentInfo){
    _isLogIn=true;

    //update all this data when login
    user=userData;
    appointment=appointmentInfo;
    if (user['details'] != null && user['details']['fav'] != null) {
      _fav = json.decode(user['details']['fav']);
    }

    notifyListeners();
  }
}