import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/Authentication/login_form.dart';
import 'package:sample/Providers/dio_prov.dart';

import '../Dimensions/dimensions.dart';
import '../main.dart';
import '../models/auth_model.dart';
import '../Widgets/button.dart';
import 'auth_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure=true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.person_outlined),
                prefixIconColor: Dimensions.primarycolor,

              ),
            ),
            Dimensions.spacesmall,
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
                  final userRegistration=await DioProvider().register(
                      _nameController.text,
                    _emailController.text,
                    _passwordController.text,);
                  print(userRegistration);
                  if (!(userRegistration is DioError)){
                    final token=await DioProvider().login(_emailController.text, _passwordController.text,);
                    if(token){
                      print(token);
                      auth.loginSuccess({},{});
                      MyApp.navigatorkey.currentState!.pushNamed('/');
                    }
                  }else{
                    print("Register not succesfull");

                  }

                },

                title: 'Sign Up',
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
