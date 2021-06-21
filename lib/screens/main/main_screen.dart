import 'package:flutter/material.dart';
import 'package:smartmath/models/user.dart';

import '../../models/activity.dart';
import 'widgets/appbar.dart';
import 'widgets/bodymain.dart';
import 'widgets/bottom.dart';
import 'widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  // static Route route() => MaterialPageRoute(builder: (context) => MainScreen());

  final User _datauser;
  MainScreen(this._datauser);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User _loguser;
  Activity _activity;
  @override
  void initState() {
    super.initState();
    _loguser = widget._datauser;
  }

  get loguser => _loguser;
  set loguser(value) => setState(() => _loguser = value);

  get activity => _activity;
  set activity(value) => setState(() => _activity = value);

  var _showdrawer = false;
  get showdrawer => _showdrawer;
  set showdrawer(value) => setState(() {
        _showdrawer = value;
        _showActivity = false;
        _editProfile = false;
        _showSubmission = false;
        _showTeachersubmission2 = false;
        _showTeachersubmission = false;
      });

  var _showActivity = true;
  get showActivity => _showActivity;
  set showActivity(value) => setState(() {
        _showActivity = value;
        _editProfile = false;
        _showdrawer = false;
        _showSubmission = false;
        _showTeachersubmission2 = false;
        _showTeachersubmission = false;
      });

  var _editProfile = false;
  get editProfile => _editProfile;
  set editProfile(value) => setState(() {
        _editProfile = value;
        _showActivity = false;
        _showdrawer = false;
        _showSubmission = false;
        _showTeachersubmission = false;
        _showStudentsubmission = false;
      });

  var _showSubmission = false;
  get showSubmission => _showSubmission;
  set showSubmission(value) => setState(() {
        _showSubmission = value;
        _showStudentsubmission2 = false;
        _showTeachersubmission2 = false;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
        _showTeachersubmission = false;
        _showStudentsubmission = false;
      });

  var _showTeachersubmission = false;
  get showTeachersubmission => _showTeachersubmission;
  set showTeachersubmission(value) => setState(() {
        _showTeachersubmission = value;
        _showTeachersubmission2 = false;
        _showSubmission = false;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  var _showTeachersubmission2 = false;
  get showTeachersubmission2 => _showTeachersubmission2;
  set showTeachersubmission2(value) => setState(() {
        _showTeachersubmission2 = value;
        _showTeachersubmission = false;
        _showSubmission = false;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  var _showStudentsubmission = false;
  get showStudentsubmission => _showStudentsubmission;
  set showStudentsubmission(value) => setState(() {
        _showStudentsubmission = value;
        _showStudentsubmission2 = false;
        _showSubmission = false;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  var _showStudentsubmission2 = false;
  get showStudentsubmission2 => _showStudentsubmission2;
  set showStudentsubmission2(value) => setState(() {
        _showStudentsubmission2 = value;
        _showStudentsubmission = false;
        _showSubmission = false;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  // dynamic route() {
  //   if (editProfile) {
  //     BodyMain(
  //       state: this,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(),
          appBar: Appbar(),
          body: BodyMain(
            state: this,
          ),
          bottomNavigationBar: Bottom(
            state: this,
          ),
        ),
      ),
    );
  }
}
