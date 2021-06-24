import 'package:flutter/material.dart';

import 'widgets/body.dart';
import 'widgets/bottom.dart';

class ChatScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => ChatScreen());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, null),
          ),
        ),
        body: Body(),
        // bottomNavigationBar: Bottom(),
      ),
    );
  }
}
