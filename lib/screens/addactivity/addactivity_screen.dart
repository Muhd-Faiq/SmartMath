import 'package:flutter/material.dart';
import 'package:smartmath/models/user.dart';

import 'widgets/body.dart';

class AddactivityScreen extends StatefulWidget {
  final User _datauser;
  AddactivityScreen(this._datauser);

  @override
  _AddactivityScreenState createState() => _AddactivityScreenState();
}

class _AddactivityScreenState extends State<AddactivityScreen> {
  User _loguser;
  @override
  void initState() {
    super.initState();
    _loguser = widget._datauser;
  }

  get loguser => _loguser;
  set loguser(value) => setState(() => _loguser = value);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: SafeArea(
        child: Scaffold(
          body: Body(
            state: this,
          ),
        ),
      ),
    );
  }
}
