import 'package:smartmath/models/activity.dart';

import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../services/activity/activity_service.dart';
import '../../models/user.dart';
import '../../models/activity.dart';
import '../viewmodel.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';

class AddactivityViewmodel extends Viewmodel {
  AddactivityViewmodel(User tempuser) {
    _user = tempuser;
  }
  AuthService get _service => dependency();
  ActivityService get _activityservice => dependency();
  User _user = User();
  Activity _activity = Activity();

  get user => _user;
  set user(value) => _user = value;

  get activity => _activity;
  set activity(value) => _activity = value;

  get title => _activity.title;
  set title(value) {
    turnBusy();
    _activity.title = value;
    turnIdle();
  }

  get description => _activity.description;
  set description(value) {
    turnBusy();
    _activity.description = value;
    turnIdle();
  }

  get urlfile => _activity.file;
  set urlfile(value) {
    turnBusy();
    _activity.file = value;
    turnIdle();
  }

  get category => _activity.category;
  set category(value) {
    turnBusy();
    _activity.category = value;
    turnIdle();
  }

  get tutorialdate => _activity.tutorialdate;
  set tutorialdate(value) {
    turnBusy();
    _activity.tutorialdate = value;
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

  Future<Activity> createnewactivity() async {
    turnBusy();
    final result = await _activityservice.createnewactivity(
      activity: Activity(
        title: activity.title,
        description: activity.description,
        file: activity.category == 'Tutorial' ? activity.file : null,
        category: activity.category,
        uid: user.id,
        date: DateFormat("yyyy-MM-dd hh:mm aa").format(DateTime.now()),
        tutorialdate:
            activity.category == 'Submission' ? activity.tutorialdate : null,
      ),
    );
    // if (result == null) _showErrorMessage = true;
    turnIdle();
    if (result != null) return _activity;
    return null;
  }
}
