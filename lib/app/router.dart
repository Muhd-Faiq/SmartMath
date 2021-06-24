import 'package:flutter/material.dart';
import 'package:smartmath/screens/addactivity/addactivity_screen.dart';
import 'package:smartmath/screens/main/main_screen.dart';
import 'package:smartmath/screens/register/register_screen.dart';
import 'package:smartmath/screens/chat_screen/chat_screen.dart';

import '../screens/login/login_screen.dart';
// import '../screens/main/main_screen.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case '/':
    case '/login':
      return LoginScreen.route();

    case '/register':
      return RegisterScreen.route();

    case '/main':
      return MaterialPageRoute(
        builder: (context) => MainScreen(settings.arguments),
      );

    case '/addactivity':
      return MaterialPageRoute(
        builder: (context) => AddactivityScreen(settings.arguments),
      );

    case '/chat':
      return ChatScreen.route();
  }
  return null;
}
