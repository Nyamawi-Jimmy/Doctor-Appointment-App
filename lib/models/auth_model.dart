import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Authentication/user.dart';


class AuthModel extends ChangeNotifier {
  bool _isLogIn = false;

  bool get isLogin{
    return _isLogIn;
  }

  void loginSuccess(){
    _isLogIn=true;
    notifyListeners();
  }
}