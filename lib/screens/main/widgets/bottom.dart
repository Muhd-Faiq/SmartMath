import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';

class Bottom extends StatelessWidget implements PreferredSizeWidget {
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
                iconSize: 40.0, color: Colors.black,
                // padding: EdgeInsets.only(right: 140.0),
                icon: Icon(Icons.notifications_rounded),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 40.0, color: Colors.black,
                // padding: EdgeInsets.only(right: 28.0),
                icon: Icon(Icons.chat_outlined),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 40.0, color: Colors.black,
                // padding: EdgeInsets.only(left: 28.0),
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// View(
//       viewmodel: MainViewmodel(),
//       builder: (context, viewmodel, _) => BottomAppBar(
//         color: Colors.red,
//       ),
//     );
