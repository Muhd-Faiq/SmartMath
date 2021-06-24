import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../models/chat.dart';
import '../../view.dart';
import '../chat_viewmodel.dart';

class Body extends StatelessWidget {
  void _onAdd(BuildContext context, ChatViewmodel viewmodel) async {
    final Chat _chat = await viewmodel.createnewchat();
    // if (_chat != null) Navigator.pop(context, _chat);
    // if (_chat != null) Navigator.pushNamed(context, '/main', arguments: _chat);
  }

  void _onCancel(BuildContext context, ChatViewmodel viewmodel) {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Chat>> _futurelistactivity = ChatViewmodel().getchat();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: View(
        viewmodel: ChatViewmodel(),
        builder: (context, viewmodel, _) => FutureBuilder<List<Chat>>(
          future: _futurelistactivity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              viewmodel.listactivity = snapshot.data;
              return Stack(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 50.0),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: viewmodel.listactivity.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (viewmodel.listactivity[index].uid !=
                                    viewmodel.user.id
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (viewmodel.listactivity[index].uid !=
                                        viewmodel.user.id
                                    ? Colors.grey.shade200
                                    : Colors.orange[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (viewmodel.listactivity[index].uid !=
                                      viewmodel.user.id)
                                    Text(
                                      viewmodel.listactivity[index].name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  if (viewmodel.listactivity[index].uid !=
                                      viewmodel.user.id)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  Text(
                                    viewmodel.listactivity[index].chat,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                                color: Colors.orange,
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
                            backgroundColor: Colors.orange,
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              viewmodel.listactivity = snapshot.data;
              return Stack(
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
              );
            }
          },
        ),
      ),
    );
  }
}
