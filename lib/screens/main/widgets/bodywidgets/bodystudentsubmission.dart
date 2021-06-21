import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartmath/models/activity.dart';
import 'package:smartmath/models/submission.dart';
import 'package:smartmath/models/user.dart';

import '../../../view.dart';
import '../../main_viewmodel.dart';

class Bodystudentsubmission extends StatelessWidget {
  Bodystudentsubmission({state}) : _state = state;
  final _state;

  // void _onUpdate(BuildContext context, MainViewmodel viewmodel) async {
  //   final User _user = await viewmodel.updateUser();

  //   // if (_user != null) Navigator.pop(context, _user);
  //   if (_user != null) {
  //     viewmodel.editProfile = false;
  //     viewmodel.loguser = _user;
  //     // Navigator.pushNamed(context, '/main');
  //   }
  // }

  // void _onCancel(BuildContext context, MainViewmodel viewmodel) {
  //   viewmodel.editProfile = false;
  // }

  @override
  Widget build(BuildContext context) {
    int progress = 0;

    String getDate(String date) {
      String temp =
          DateFormat('EEEE').format(DateTime.parse(date.substring(0, 10))) +
              ', ' +
              date.substring(8, 10) +
              '/' +
              date.substring(5, 7) +
              '/' +
              date.substring(0, 4);
      if (date.substring(12, 13) == ':')
        return temp + date.substring(10, 15) + 'AM';
      else if (date.substring(13, 14) == ':' && date.length == 16)
        return temp +
            ' ' +
            (int.parse(date.substring(11, 13)) - 12).toString() +
            date.substring(13, 16) +
            'PM';
      else if (date.substring(11, 13) == '12')
        return temp + date.substring(10, 16) + 'PM';
      else if (date.substring(17, 19) == 'PM' || date.substring(17, 19) == 'AM')
        return temp + ' ' + date.substring(11, 19);

      return null;
      // return temp +
      //     (int.parse(date.substring(11, 13)) - 12).toString() +
      //     date.substring(13, 16) +
      //     'PM';
    }

    int getRemainingDate(String date) {
      String tempdate = date;
      if (date.substring(12, 13) == ':')
        tempdate = date.substring(0, 11) + '0' + date.substring(11, 15);
      int days;
      days = DateTime.parse(tempdate).difference(DateTime.now()).inDays;
      return days;
    }

    // String date;

    Future<Submission> _futurelistactivity = MainViewmodel().getSubmission();

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: View(
        viewmodel: MainViewmodel(),
        builder: (context, viewmodel, _) => FutureBuilder<Submission>(
          future: _futurelistactivity,
          builder: (context, snapshot) {
            viewmodel.submission = snapshot.data;

            return Container(
              margin: const EdgeInsets.only(bottom: 150.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          right: 6.0,
                          left: 6.0,
                          bottom: 40.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Title: ${viewmodel.activity.title}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Table(
                              border: TableBorder.all(),
                              columnWidths: const <int, TableColumnWidth>{
                                0: IntrinsicColumnWidth(),
                                1: FlexColumnWidth(),
                              },
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              children: <TableRow>[
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 128,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Submission Status",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          viewmodel.submissiontemp != null
                                              ? 'Already Submitted'
                                              : 'Not Yet Submitted',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 128,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Due Date",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${getDate(viewmodel.activity.tutorialdate)}',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 128,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Time Remaining",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            '${getRemainingDate(viewmodel.activity.tutorialdate)} days'),
                                      ),
                                    ),
                                  ],
                                ),
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 128,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Last Modified",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            viewmodel.submissiontemp != null
                                                ? getDate(viewmodel
                                                    .submissiontemp.datesubmit)
                                                : ' '),
                                      ),
                                    ),
                                  ],
                                ),
                                if (viewmodel.submissiontemp != null)
                                  TableRow(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    children: <Widget>[
                                      Container(
                                        height: 64,
                                        width: 128,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "File Submission",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final status = await Permission
                                              .storage
                                              .request();
                                          if (status.isGranted) {
                                            final externalDirectory =
                                                await getExternalStorageDirectory();
                                            final id =
                                                await FlutterDownloader.enqueue(
                                              url: viewmodel
                                                  .submissiontemp.filesubmit,
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
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'File',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      height: 64,
                                      width: 128,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Comment",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          viewmodel.submissiontemp != null
                                              ? viewmodel.submissiontemp
                                                          .comment !=
                                                      null
                                                  ? viewmodel
                                                      .submissiontemp.comment
                                                  : 'None'
                                              : 'None',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      if (getRemainingDate(viewmodel.activity.tutorialdate) > 0)
                        SizedBox(
                          child: MaterialButton(
                            color: Colors.orange,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    viewmodel.submissiontemp != null
                                        ? 'Update Submission'
                                        : 'Add Submission',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () =>
                                _state.showStudentsubmission2 = true,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
