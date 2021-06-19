import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smartmath/models/activity.dart';
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
  //     _state.editProfile = false;
  //     _state.loguser = _user;
  //     // Navigator.pushNamed(context, '/main');
  //   }
  // }

  // void _onCancel(BuildContext context, MainViewmodel viewmodel) {
  //   _state.editProfile = false;
  // }

  int progress = 0;

  String getDate(String date) {
    if (date.substring(12, 13) == ':')
      return date.substring(10, 15) + 'AM';
    else if (date.substring(11, 13) == '12')
      return date.substring(10, 16) + 'PM';

    return (int.parse(date.substring(11, 13)) - 12).toString() +
        date.substring(13, 16) +
        'PM';
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Activity>> _futurelistactivity =
        MainViewmodel(User.copy(_state.loguser)).getactivity();
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: View(
        viewmodel: MainViewmodel(User.copy(_state.loguser)),
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
                      if (viewmodel.listactivity[index].category ==
                          'Submission')
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
                                    'Due Date: ' +
                                        viewmodel
                                            .listactivity[index].tutorialdate
                                            .substring(8, 10) +
                                        '/' +
                                        viewmodel
                                            .listactivity[index].tutorialdate
                                            .substring(5, 7) +
                                        '/' +
                                        viewmodel
                                            .listactivity[index].tutorialdate
                                            .substring(0, 4),
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
                                  color: Colors.orange,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          'View Submission',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () => _state.Submission = true,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    viewmodel.listactivity[index].tutorialdate
                                            .substring(8, 10) +
                                        '/' +
                                        viewmodel
                                            .listactivity[index].tutorialdate
                                            .substring(5, 7) +
                                        '/' +
                                        viewmodel
                                            .listactivity[index].tutorialdate
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
                                    getDate(viewmodel
                                        .listactivity[index].tutorialdate),
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
