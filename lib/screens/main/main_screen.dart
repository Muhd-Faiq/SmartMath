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
  set showdrawer(value) => setState(() => _showdrawer = value);

  var _editProfile = false;
  get editProfile => _editProfile;
  set editProfile(value) => setState(() => _editProfile = value);

  dynamic route() {
    if (editProfile) {
      BodyMain(
        state: this,
      );
    }
  }

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
