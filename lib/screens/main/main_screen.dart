import 'package:flutter/material.dart';
import 'package:smartmath/models/user.dart';

import 'widgets/appbar.dart';
import 'widgets/bodymain.dart';
import 'widgets/bottom.dart';
import 'widgets/drawer.dart';

// class MainScreen extends StatelessWidget {
//   static Route route() => MaterialPageRoute(builder: (context) => MainScreen());
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: Appbar(),
//           body: Body(),
//           bottomNavigationBar: Bottom(),
//           drawer: DrawerCustom(),
//         ),
//       ),
//     );
//   }
// }
class MainScreen extends StatefulWidget {
  // static Route route() => MaterialPageRoute(builder: (context) => MainScreen());

  final User _datauser;
  MainScreen(this._datauser);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  User _loguser;
  @override
  void initState() {
    super.initState();
    _loguser = widget._datauser;
  }

  get loguser => _loguser;
  set loguser(value) => setState(() => _loguser = value);

  var _showdrawer = false;
  get showdrawer => _showdrawer;
  set showdrawer(value) => setState(() {
        _showdrawer = value;
        _showActivity = false;
        _editProfile = false;
        _showSubmission = false;
      });

  var _showActivity = true;
  get showActivity => _showActivity;
  set showActivity(value) => setState(() {
        _showActivity = value;
        _editProfile = false;
        _showdrawer = false;
        _showSubmission = false;
      });

  var _editProfile = false;
  get editProfile => _editProfile;
  set editProfile(value) => setState(() {
        _editProfile = value;
        _showActivity = false;
        _showdrawer = false;
        _showSubmission = false;
      });

  var _showSubmission = false;
  get showSubmission => _showSubmission;
  set showSubmission(value) => setState(() {
        _showSubmission = value;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  var _showTeachersubmission = false;
  get showTeachersubmission => _showTeachersubmission;
  set showTeachersubmission(value) => setState(() {
        _showTeachersubmission = value;
        _editProfile = false;
        _showdrawer = false;
        _showActivity = false;
      });

  var _showStudentsubmission = false;
  get showStudentsubmission => _showStudentsubmission;
  set showStudentsubmission(value) => setState(() {
        _showStudentsubmission = value;
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
          appBar: Appbar(
            state: this,
          ),
          body: BodyMain(
            state: this,
          ),
          bottomNavigationBar: Bottom(
            state: this,
          ),
          endDrawer: DrawerCustom(
            state: this,
          ),
        ),
      ),
    );
  }
}
