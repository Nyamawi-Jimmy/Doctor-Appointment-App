
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Dimensions/dimensions.dart';
import '../Providers/dio_provider.dart';
import '../Widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  bool _isObscure=true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Dimensions.spacesmall,
          Button(
            onPressed: () async{

              //Login page
              final token=await DioProvider()
                  .getToken(_emailController.text, _passwordController.text);
              print(token);
              //Navigator.of(context).pushNamed("main");
            },
            title: 'Sign In',
            width: double.maxFinite,
            disable: false,),
          Dimensions.spacesmall,

        ],
      ),
    );
  }
}