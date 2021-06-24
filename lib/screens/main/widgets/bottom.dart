import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';

class Bottom extends StatelessWidget implements PreferredSizeWidget {
  Bottom({state}) : _state = state;
  final _state;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return View(
      viewmodel: MainViewmodel(),
      builder: (context, viewmodel, _) => BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.orange,
        child: Container(
          height: 65,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                iconSize: 40.0,
                color: Colors.black,
                icon: Icon(Icons.notifications_rounded),
                onPressed: () => _state.showActivity = true,
              ),
              IconButton(
                iconSize: 40.0,
                color: Colors.black,
                icon: Icon(Icons.chat_outlined),
                onPressed: () => Navigator.pushNamed(context, '/chat'),
              ),
              IconButton(
                iconSize: 40.0,
                color: Colors.black,
                icon: Icon(Icons.more_horiz),
                onPressed: () => _state.showdrawer
                    ? _state.showdrawer = false
                    : _state.showdrawer = true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
