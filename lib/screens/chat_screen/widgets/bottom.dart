import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../models/chat.dart';
import '../../view.dart';
import '../chat_viewmodel.dart';

class Bottom extends StatelessWidget {
  void _onAdd(BuildContext context, ChatViewmodel viewmodel) async {
    final Chat _chat = await viewmodel.createnewchat();
    // if (_chat != null) Navigator.pop(context, _chat);
    if (_chat != null) Navigator.pushNamed(context, '/main', arguments: _chat);
  }

  void _onCancel(BuildContext context, ChatViewmodel viewmodel) {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: View(
        viewmodel: ChatViewmodel(),
        builder: (context, viewmodel, _) => Container(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) => viewmodel.chat = value,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () => _onAdd(context, viewmodel),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
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
