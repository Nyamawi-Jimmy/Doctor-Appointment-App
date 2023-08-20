import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/Providers/dio_prov.dart';
import 'package:sample/main.dart';
import 'package:sample/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Dimensions/dimensions.dart';
import '../Widgets/button.dart';
import 'dart:convert';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscure=true;
  bool _isLoading = false;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email Address",
                labelText: "Email",
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Dimensions.primarycolor,

              ),
            ),
            Dimensions.spacesmall,
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Dimensions.primarycolor,
              obscureText: _isObscure,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.lock_outlined),
                  prefixIconColor: Dimensions.primarycolor,
                  suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _isObscure=!_isObscure;
                      });
                    },icon: _isObscure==true? const Icon(Icons.visibility_off_outlined,color: Colors.black38,)
                      :const Icon(Icons.visibility_outlined,color: Dimensions.primarycolor,),)
              ),
            ),


            SizedBox(
              height: 10,
            ),
               Consumer<AuthModel>(
                 builder: (context, auth, child){
                   return Button(
                     onPressed: () async {
                       final token=await DioProvider().login(_emailController.text, _passwordController.text,);
                       print(token);
                        if(token){
                           auth.loginSuccess({},{});
                           //grab user data

                           final SharedPreferences prefs = await SharedPreferences.getInstance();
                           final tokenValue=prefs.getString('token')??'';

                           if(tokenValue.isNotEmpty && tokenValue !=''){
                             final response = await DioProvider().getUser(tokenValue);
                             if(response!=null){
                               setState(() {
                                 Map <String,dynamic> appointment={};
                                 final user = json.decode(response);
                                 //print(user);
                                 //check todays appointment if there is any return for today
                                 for(var doctorData in user ['doctor']){
                                   //if there is any pass for today and then the doctor info
                                   if(doctorData['appointments']!=null){
                                     appointment=doctorData;
                                     print(appointment);
                                   }
                                 }
                                 auth.loginSuccess(user,appointment);
                                 MyApp.navigatorkey.currentState!.pushNamed('main');
                               });
                             }
                           }

                        }
                     },
                     title: 'Sign In',
                     width: double.maxFinite,
                     disable: false,);
                 }
               )

          ],
        ),
      ),
    );
  }
}
