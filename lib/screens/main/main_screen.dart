import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import 'widgets/body.dart';
import 'widgets/bottom.dart';
import 'widgets/drawer.dart';

class MainScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => MainScreen());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          appBar: Appbar(),
          body: Body(),
          bottomNavigationBar: Bottom(),
          drawer: DrawerCustom(),
        ),
      ),
    );
  }
}
