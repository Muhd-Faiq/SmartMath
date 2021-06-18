import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';

// class Bottom extends StatefulWidget {
//   // const Bottom({ Key? key }) : super(key: key);

//   @override
//   _BottomState createState() => _BottomState();
// }

// class _BottomState extends State<Bottom> {
//   void _onLogin(BuildContext context, MainViewmodel viewmodel) async {
//     final User _user = await viewmodel.authenticate();

//     // if (_user != null) Navigator.pop(context, _user);
//     if (_user != null) Navigator.pushNamed(context, '/register');
//   }

//   void _onCancel(BuildContext context, MainViewmodel viewmodel) {
//     viewmodel.showErrorMessage = false;
//     Navigator.pop(context, null);
//   }

//   var _showdrawer = false;
//   get showdrawer => _showdrawer;
//   set showdrawer(value) => setState(() => _showdrawer = value);

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return View(
//       viewmodel: MainViewmodel(),
//       builder: (context, viewmodel, _) => SingleChildScrollView(
//         child: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           color: Colors.orange,
//           child: Container(
//             height: 65,
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 IconButton(
//                   iconSize: 40.0,
//                   color: Colors.black,
//                   icon: Icon(Icons.notifications_rounded),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   iconSize: 40.0,
//                   color: Colors.black,
//                   icon: Icon(Icons.chat_outlined),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   iconSize: 40.0,
//                   color: Colors.black,
//                   icon: Icon(Icons.more_horiz),
//                   onPressed: () {
//                     showdrawer ? showdrawer = false : showdrawer = true;
//                   },
//                 ),
//                 if (showdrawer)
//                   AnimatedOpacity(
//                     duration: Duration(milliseconds: 200),
//                     opacity: 1.0,
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                       child: Container(
//                         color: Colors.black.withOpacity(0.2),
//                       ),
//                     ),
//                   ),
//                 if (showdrawer)
//                   AnimatedPositioned(
//                     curve: Curves.easeInOut,
//                     duration: Duration(milliseconds: 200),
//                     left: 0,
//                     bottom: 60,
//                     // bottom: (showBottomMenu)?-60:-(height/3),
//                     child: MenuWidget(),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Bottom extends StatelessWidget implements PreferredSizeWidget {
  Bottom({state}) : _state = state;
  final _state;

  @override
  Size get preferredSize => const Size.fromHeight(50);

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
                onPressed: () {},
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
