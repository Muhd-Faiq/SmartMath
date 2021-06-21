import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmath/models/submission.dart';
import 'package:smartmath/screens/view.dart';
import 'package:path/path.dart';
import '../../main_viewmodel.dart';
import 'dart:isolate';
import 'dart:ui';

class Teachersubmission extends StatelessWidget {
  Teachersubmission({state}) : _state = state;
  final _state;

  void _onUpdatesubmission(
      BuildContext context, MainViewmodel viewmodel) async {
    final Submission _submission2 = await viewmodel.updateCommentSubmission();
    if (_submission2 != null) {
      _state.showTeachersubmission = true;
      print('no');
    } else {
      _state.showSubmission = true;
      print('yes');
    }
  }

  void _onCancel(BuildContext context, MainViewmodel viewmodel) {
    _state.showSubmission = true;
    print('yes');
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Submission>> _futurelistactivity =
        MainViewmodel().getActvitySubmission();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: View(
        viewmodel: MainViewmodel(),
        builder: (context, viewmodel, _) => FutureBuilder<List<Submission>>(
            future: _futurelistactivity,
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30.0,
                        right: 15.0,
                        left: 15.0,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        right: 6.0,
                        left: 6.0,
                        bottom: 20.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Title: ${viewmodel.activity.title}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Name: ${viewmodel.student.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        right: 15.0,
                        left: 15.0,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        right: 6.0,
                        left: 6.0,
                        bottom: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          color: Colors.orange,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'DOWNLOAD FILE',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.orange,
                                )
                              ],
                            ),
                          ),
                          onPressed: () async {
                            final status = await Permission.storage.request();
                            if (status.isGranted) {
                              final externalDirectory =
                                  await getExternalStorageDirectory();
                              print(viewmodel.submissiontemp.filesubmit);
                              final id = await FlutterDownloader.enqueue(
                                url: viewmodel.submissiontemp.filesubmit,
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
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 32,
                        ),
                        Text(
                          'Enter Comment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Comment',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => viewmodel.commenttemp = value,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 6.0,
                        left: 6.0,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        right: 6.0,
                        left: 6.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            color: Colors.orange,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Saved',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () =>
                                _onUpdatesubmission(context, viewmodel),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MaterialButton(
                            color: Colors.orange,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () => _onCancel(context, viewmodel),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
