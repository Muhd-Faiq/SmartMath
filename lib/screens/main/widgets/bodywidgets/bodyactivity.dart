import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmath/models/activity.dart';
import 'package:smartmath/models/user.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../../../view.dart';
import '../../main_viewmodel.dart';

class BodyActivity extends StatefulWidget {
  BodyActivity({state}) : _state = state;
  final _state;

  @override
  _BodyActivityState createState() => _BodyActivityState();
}

class _BodyActivityState extends State<BodyActivity> {
  // void _onUpdate(BuildContext context, MainViewmodel viewmodel) async {
  //   final User _user = await viewmodel.updateUser();

  //   // if (_user != null) Navigator.pop(context, _user);
  //   if (_user != null) {
  //     _state.editProfile = false;
  //     _state.loguser = _user;
  //     // Navigator.pushNamed(context, '/main');
  //   }
  // }

  // void _onCancel(BuildContext context, MainViewmodel viewmodel) {
  //   _state.editProfile = false;
  // }

  int progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///ssending the data
    sendPort.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    ///register a send port for the other isolates
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is comming other isolataes
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Activity>> _futurelistactivity = MainViewmodel().getactivity();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: View(
        viewmodel: MainViewmodel(),
        builder: (context, viewmodel, _) => FutureBuilder<List<Activity>>(
          future: _futurelistactivity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              viewmodel.listactivity = snapshot.data;
              return Container(
                margin: const EdgeInsets.only(bottom: 150.0),
                child: ListView.separated(
                  reverse: true,
                  itemCount: viewmodel.listactivity.length,
                  separatorBuilder: (context, index) => Container(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      if (viewmodel.listactivity[index].category == 'Tutorial')
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            right: 6.0,
                            left: 6.0,
                            bottom: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Title: ${viewmodel.listactivity[index].title}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Description:',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    viewmodel.listactivity[index].description,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'DOWNLOAD FILE',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    final status =
                                        await Permission.storage.request();
                                    if (status.isGranted) {
                                      final externalDirectory =
                                          await getExternalStorageDirectory();
                                      final id =
                                          await FlutterDownloader.enqueue(
                                        url: viewmodel.listactivity[index].file,
                                        savedDir: externalDirectory.path,
                                        fileName: 'download',
                                        showNotification:
                                            true, // show download progress in status bar (for Android)
                                        openFileFromNotification:
                                            true, // click on notification to open downloaded file (for Android)
                                      );
                                    } else {
                                      print('permission denied');
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    viewmodel.listactivity[index].date
                                            .substring(8, 10) +
                                        '/' +
                                        viewmodel.listactivity[index].date
                                            .substring(5, 7) +
                                        '/' +
                                        viewmodel.listactivity[index].date
                                            .substring(0, 4),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    viewmodel.listactivity[index].date
                                        .substring(10, 19),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
