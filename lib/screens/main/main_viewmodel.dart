import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:smartmath/services/activityviewmodel.dart';
import 'package:smartmath/services/listsubmissionviewmodel.dart';
import 'package:smartmath/services/listuserviewmodel.dart';
import 'package:smartmath/services/studentviewmodel.dart';
import 'package:smartmath/services/userviewmodel.dart';
import 'package:smartmath/services/submissionviewmodel.dart';
import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../services/activity/activity_service.dart';
import '../../services/submission/submission_service.dart';
import '../../models/user.dart';
import '../../models/activity.dart';
import '../../models/submission.dart';
import '../viewmodel.dart';
import 'dart:io';

import 'package:flutter/scheduler.dart';

class MainViewmodel extends Viewmodel {
  User _usercopy;
  MainViewmodel() {
    _usercopy = User.copy(_userdependency.user);
    // if (_userdependency.user.role == 'Teacher') getallstudent();
  }
  MainViewmodel.p(String y) {
    _usercopy = User.copy(_userdependency.user);
    if (_userdependency.user.role == 'Teacher') {
      getallstudent();
      getActvitySubmission();
    }
  }

  AuthService get _service => dependency();
  UserViewmodel get _userdependency => dependency();
  StudentViewmodel get _studentdependency => dependency();
  ListUserViewmodel get _listuserdependency => dependency();
  ActivityViewmodel get _activitydependency => dependency();
  ActivityService get _activityservice => dependency();
  SubmissionService get _submissionservice => dependency();
  SubmissionViewmodel get _submissiondependency => dependency();
  ListSubmissionViewmodel get _listsubmissiondependency => dependency();
  List<User> _listuser;
  Submission _submission = Submission();
  Activity _activity = Activity();
  List<Activity> _listactivity;
  List<Submission> _listsubmission;
  Future<List<Activity>> _futurelistactivity;
  // User _tempuser;

  get user => _userdependency.user;
  set user(value) => _userdependency.user = value;

  get student => _studentdependency.student;
  set student(value) => _studentdependency.student = value;

  get usercopy => _usercopy;
  set usercopy(value) => _usercopy = value;

  get listuser => _listuserdependency.listuser;
  set listuser(value) => _listuserdependency.listuser = value;

  get activity => _activitydependency.activity;
  set activity(value) => _activitydependency.activity = value;

  get submission => _submission;
  set submission(value) => _submission = value;

  get submissiontemp => _submissiondependency.submission;
  set submissiontemp(value) => _submissiondependency.submission = value;

  get listactivity => _listactivity;
  set listactivity(value) => _listactivity = value;

  get listsubmission => _listsubmission;
  set listsubmission(value) => _listsubmission = value;

  get templistsubmission => _listsubmissiondependency.listsubmission;
  set templistsubmission(value) =>
      _listsubmissiondependency.listsubmission = value;

  get futurelistactivity => _futurelistactivity;
  set futurelistactivity(value) => _futurelistactivity = value;

  get username => user.login;
  set username(value) {
    turnBusy();
    user.login = value;
    turnIdle();
  }

  get password => user.password;
  set password(value) {
    turnBusy();
    user.password = value;
    turnIdle();
  }

  get name => user.name;
  set name(value) {
    turnBusy();
    user.name = value;
    turnIdle();
  }

  get usernamecopy => usercopy.login;
  set usernamecopy(value) {
    turnBusy();
    usercopy.login = value;
    turnIdle();
  }

  get passwordcopy => usercopy.password;
  set passwordcopy(value) {
    turnBusy();
    usercopy.password = value;
    turnIdle();
  }

  get namecopy => usercopy.name;
  set namecopy(value) {
    turnBusy();
    usercopy.name = value;
    turnIdle();
  }

  Future<User> updateUser() async {
    turnBusy();
    final result = await _service.updateUser(
      user: User(
        id: usercopy.id,
        login: usercopy.login,
        name: usercopy.name,
        password: usercopy.password,
        role: usercopy.role == 'Teacher' ? 'Teacher' : 'Student',
      ),
    );
    if (result == null) return null;
    turnIdle();
    _userdependency.user = result;
    return result;
  }

  Future<List<Activity>> getactivity() async {
    turnBusy();
    final _activity = await _activityservice.getactivity();
    if (_activity == null) return null;
    turnIdle();
    _activity.sort((a, b) {
      var adate = a.date; //before -> var adate = a.expiry;
      var bdate = b.date; //var bdate = b.expiry;
      return adate.compareTo(bdate);
    });
    return _activity;
  }

  get filesubmit => submission.filesubmit;
  set filesubmit(value) {
    turnBusy();
    submission.filesubmit = value;
    turnIdle();
  }

  get comment => submission.comment;
  set comment(value) {
    turnBusy();
    submission.comment = value;
    turnIdle();
  }

  Future uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<Submission> createnewsubmission() async {
    turnBusy();
    final result = await _submissionservice.createnewsubmission(
      submission: Submission(
        comment: submission.comment,
        datesubmit: DateFormat("yyyy-MM-dd hh:mm aa").format(DateTime.now()),
        filesubmit: submission.filesubmit,
        uid: user.id,
        aid: activity.id,
      ),
    );
    turnIdle();
    if (result != null) return result;
    return null;
  }

  Future<Submission> updateSubmission() async {
    turnBusy();
    final result = await _submissionservice.updateSubmission(
      submission: Submission(
        comment: submissiontemp.comment,
        datesubmit: DateFormat("yyyy-MM-dd hh:mm aa").format(DateTime.now()),
        filesubmit: submission.filesubmit,
        uid: submissiontemp.uid,
        aid: submissiontemp.aid,
        id: submissiontemp.id,
      ),
    );
    turnIdle();
    if (result != null) return result;
    return null;
  }

  String _commenttemp;
  get commenttemp => _commenttemp;
  set commenttemp(value) => _commenttemp = value;

  Future<Submission> updateCommentSubmission() async {
    turnBusy();
    final result = await _submissionservice.updateSubmission(
      submission: Submission(
        comment: commenttemp,
        datesubmit: submissiontemp.datesubmit,
        filesubmit: submissiontemp.filesubmit,
        uid: submissiontemp.uid,
        aid: submissiontemp.aid,
        id: submissiontemp.id,
      ),
    );
    turnIdle();
    if (result != null) return result;
    return null;
  }

  Future<Submission> getSubmission() async {
    turnBusy();
    final Submission _sub =
        await _submissionservice.getSubmission(aid: activity.id, uid: user.id);
    if (_sub == null) return null;
    turnIdle();
    submissiontemp = _sub;
    return _sub;
  }

  Future<List<Submission>> getActvitySubmission() async {
    turnBusy();
    final _sub =
        await _submissionservice.getActvitySubmission(aid: activity.id);
    if (_sub == null) return null;
    turnIdle();
    _listsubmissiondependency.listsubmission = _sub;
    return _sub;
  }

  void getallstudent2() {
    turnBusy();
    final _user = _service.getalluser(role: 'Student');
    if (_user == null) print('null');
    turnIdle();
    _listuserdependency.listuser = _user;
  }

  Future<List<User>> getallstudent() async {
    turnBusy();
    final _user = await _service.getalluser(role: 'Student');
    if (_user == null) return null;
    turnIdle();
    _listuserdependency.listuser = _user;
    return _user;
  }
}
