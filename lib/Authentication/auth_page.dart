import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/Authentication/sign_up.dart';

import '../Dimensions/dimensions.dart';
import 'login_form.dart';
import '../Widgets/social_buttons.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn=true;
  @override
  Widget build(BuildContext context) {
    Dimensions().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              Dimensions.spacesmall,
              Text(
                isSignIn
                ?"Sign in to your account"!:"You can easily SIgnUp and connect to the doctors near you!"!,style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),),
              Dimensions.spacesmall,
             isSignIn?LoginScreen():SignUp(),
              isSignIn ? Center(
                child: TextButton(
                  onPressed: (){},
                  child: Text("Forgot Your Password",style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ):Container(),
              const Spacer(),
              Center(
                child: Text("Or continue with social account?",style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500
                ),),
              ),
              Dimensions.spacesmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButtons(social: "google") ,
                  SocialButtons(social: "facebook"),
                  Dimensions.spacesmall,

                ],
              ),
              Dimensions.spacesmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isSignIn? "Dont have an account?":"Already have an account?",style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),),
                  TextButton(
                    onPressed: (){setState(() {
                      isSignIn=!isSignIn;
                    });
  },
                    child: Text(
                      isSignIn? "Sign Up.":"Sign In",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}