import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';

class DrawerCustom extends StatelessWidget {
  DrawerCustom({state}) : _state = state;
  final _state;
  void _onLogin(BuildContext context, MainViewmodel viewmodel) async {
    final User _user = await viewmodel.authenticate();

    // if (_user != null) Navigator.pop(context, _user);
    if (_user != null) Navigator.pushNamed(context, '/register');
  }

  void _onCancel(BuildContext context, MainViewmodel viewmodel) {
    viewmodel.showErrorMessage = false;
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return View(
      viewmodel: MainViewmodel(User.copy(_state.loguser)),
      builder: (context, viewmodel, _) => Drawer(
        child: Container(
          color: Colors.red,
        ),
      ),
    );
  }
}
