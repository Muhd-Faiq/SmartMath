import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';
import 'bodywidgets/bodyeditprofile.dart';
import 'bodywidgets/bodyactivity.dart';
import 'bodywidgets/more.dart';

class BodyMain extends StatelessWidget {
  BodyMain({state}) : _state = state;
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: View(
        viewmodel: MainViewmodel(User.copy(_state.loguser)),
        builder: (context, viewmodel, _) => Scaffold(
          body: Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        if (_state.editProfile) Bodyeditprofile(state: _state),
                        if (_state.showActivity) BodyActivity(state: _state),
                      ],
                    ),
                  ),
                ),
                if (_state.showdrawer)
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: _state.showdrawer ? 1.0 : 0.0,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                if (_state.showdrawer)
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200),
                    // left: 20,
                    // bottom: -60,
                    bottom: _state.showdrawer ? -60 : -(height / 3),
                    child: MenuWidget(
                      state: _state,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
