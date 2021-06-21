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

class Bodyteachersubmission extends StatelessWidget {
  Bodyteachersubmission({state}) : _state = state;
  final _state;

  bool getCheck(List<Submission> list, String userid) {
    int i = 0;
    list.forEach((value) {
      if (value.uid == userid) {
        i = 1;
      }
    });
    if (i == 1) return true;
    return false;
  }

  bool getCheck2(List<Submission> list) {
    int i = 0;
    list.forEach((value) {
      if (value.comment != null) {
        i = 1;
      }
    });
    if (i == 1) return true;
    return false;
  }

  void getCheck3(
      List<Submission> list, String userid, MainViewmodel viewmodel) {
    int i = 0;
    list.forEach((value) {
      if (value.uid == userid) {
        i = 1;
        viewmodel.submissiontemp = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MainViewmodel().getallstudent();
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
            viewmodel.listsubmission = snapshot.data;
            viewmodel.student = null;
            viewmodel.submissiontemp = null;
            print('lengtgh==${viewmodel.listuser.length}');
            return Container(
              margin: const EdgeInsets.only(bottom: 110.0),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  right: 6.0,
                  left: 6.0,
                ),
                child: ListView.separated(
                  itemCount: viewmodel.listuser.length,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 3,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            viewmodel.listuser[index].name,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          // if (getCheck(viewmodel.listsubmission,
                          //         viewmodel.listuser[index].id) ==
                          //     true)
                          Icon(
                            getCheck(viewmodel.listsubmission,
                                    viewmodel.listuser[index].id)
                                ? getCheck2(viewmodel.listsubmission)
                                    ? Icons.done_all
                                    : Icons.done
                                : Icons.close,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      if (getCheck(viewmodel.listsubmission,
                          viewmodel.listuser[index].id)) {
                        getCheck3(viewmodel.listsubmission,
                            viewmodel.listuser[index].id, viewmodel);
                        viewmodel.student = viewmodel.listuser[index];
                        _state.showTeachersubmission2 = true;
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
