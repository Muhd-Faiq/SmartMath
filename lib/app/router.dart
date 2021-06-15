import 'package:flutter/material.dart';
import 'package:smartmath/screens/main/main_screen.dart';
import 'package:smartmath/screens/register/register_screen.dart';

import '../screens/login/login_screen.dart';
// import '../screens/main/main_screen.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
    case '/login':
      return LoginScreen.route();

    case '/register':
      return RegisterScreen.route();

    // case '/main':
    //   return MainScreen.route();
    case '/main':
      return MaterialPageRoute(
        builder: (context) => MainScreen(settings.arguments),
      );
  }
  return null;
}
