import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider{
  Future <dynamic> login(String email,String password) async {
    try{
var response=await Dio().post('https://gambo.rickieyngambo.xyz/appointment/api/sanctum/token',
    data: {'email':email,'password':password,});
          if (response.statusCode==200 && response.data!=''){
            print(response.statusCode);
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', response.data);
            print(response.data);
            return true;
          }else{
            return false;
          }
    }catch(error){
return error;
    }
  }

  Future <dynamic> getUser(String token) async {
try{
  var user=await Dio().get('https://gambo.rickieyngambo.xyz/appointment/api/user',
      options:Options(headers: {'Authorization': 'Bearer $token'}));
  if (user.statusCode==200 && user.data!=''){
    return json.encode(user.data);
  }
}catch(error){
  return error;
}

  }

  Future <dynamic> register(String username,String email,String password ) async {
    try{
      var user=await Dio().post('https://gambo.rickieyngambo.xyz/appointment/api/register',
          data: {'name':username,'email':email,'password':password,});
      if (user.statusCode==201 && user.data!=''){
        return true;
      }else{
        return false;
      }
    }catch(error){
      return error;
    }

  }
//Booking appointments
  Future <dynamic> bookAppointment(String day,String date,String time, int doctor, String token ) async {
    try{
      var response=await Dio().post('https://gambo.rickieyngambo.xyz/appointment/api/book',
          data: {'day':day,'date':date,'time':time,'doctor_id':doctor},
          options:Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode==200 && response.data!=''){
        return response.statusCode;
      }else{
        return 'error';
      }
    }catch(error){
      return error;
    }

  }

  //Retrieve appointments
  Future <dynamic> getAppointment(String token ) async {
    try{
      var response=await Dio().get('https://gambo.rickieyngambo.xyz/appointment/api/appointments',
          options:Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode==200 && response.data!=''){
        return json.encode(response.data);
      }else{
        return 'error';
      }
    }catch(error){
      return error;
    }

  }

}