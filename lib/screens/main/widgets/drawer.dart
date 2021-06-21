import 'package:flutter/material.dart';

import '../../view.dart';
import '../main_viewmodel.dart';

class DrawerCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return View(
      viewmodel: MainViewmodel(),
      builder: (context, viewmodel, _) => Drawer(
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
