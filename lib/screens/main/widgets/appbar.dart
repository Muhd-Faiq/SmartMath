import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../view.dart';
import '../main_viewmodel.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    //return AppBar();
    return AppBar(
      leading: CircleAvatar(
          backgroundImage: AssetImage('assets/image/editprofile.png')),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(MainViewmodel().user.name),
          Text('${MainViewmodel().user.login} (${MainViewmodel().user.role})',
              style: TextStyle(fontSize: 12.0)),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              MainViewmodel().user = null;
              Navigator.pop(context);
            })
      ],
    );
  }
}

// child: View(
//   viewmodel: MainViewmodel(),
//   builder: (context, viewmodel, _) => SingleChildScrollView(
//     child: Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [],
//     ),
//   ),
// ),
