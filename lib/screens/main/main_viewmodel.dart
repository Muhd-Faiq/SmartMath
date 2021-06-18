import 'package:intl/intl.dart';
import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../services/activity/activity_service.dart';
import '../../models/user.dart';
import '../../models/activity.dart';
import '../viewmodel.dart';

class MainViewmodel extends Viewmodel {
  MainViewmodel(User tempuser) {
    _user = tempuser;
  }
  AuthService get _service => dependency();
  ActivityService get _activityservice => dependency();
  User _user = User();
  Activity _activity = Activity();
  List<Activity> _listactivity;
  Future<List<Activity>> _futurelistactivity;
  // User _tempuser;

  bool _showPassword = false;
  bool _showErrorMessage = false;

  get user => _user;
  set user(value) => _user = value;

  get activity => _activity;
  set activity(value) => _activity = value;

  get listactivity => _listactivity;
  set listactivity(value) => _listactivity = value;

  get futurelistactivity => _futurelistactivity;
  set futurelistactivity(value) => _futurelistactivity = value;

  get showPassword => _showPassword;
  set showPassword(value) {
    turnBusy();
    _showPassword = value;
    turnIdle();
  }

  get showErrorMessage => _showErrorMessage;
  set showErrorMessage(value) {
    turnBusy();
    _showErrorMessage = value;
    turnIdle();
  }

  get username => _user.login;
  set username(value) {
    turnBusy();
    _showErrorMessage = false;
    _user.login = value;
    turnIdle();
  }

  get password => _user.password;
  set password(value) {
    turnBusy();
    _showErrorMessage = false;
    _user.password = value;
    turnIdle();
  }

  get name => _user.name;
  set name(value) {
    turnBusy();
    _showErrorMessage = false;
    _user.name = value;
    turnIdle();
  }

  Future<User> authenticate() async {
    turnBusy();
    final User _user =
        await _service.authenticate(login: username, password: password);
    if (_user == null) _showErrorMessage = true;
    turnIdle();
    return _user;
  }

  Future<User> updateUser() async {
    turnBusy();
    final result = await _service.updateUser(
      user: User(
        id: user.id,
        login: user.login,
        name: user.name,
        password: user.password,
        role: user.role == 'Teacher' ? 'Teacher' : 'Student',
      ),
    );
    if (result == null) _showErrorMessage = true;
    turnIdle();
    return _user;
  }

//   todayDate(List<Activity> act) {
//     List products = [];

// //adding into the new list from raw API list
//     for (final item in act) {
//       var parsedDate = DateTime.parse(item.date);

//       products.add(tmpArray);
//     }
//   }

  Future<List<Activity>> getactivity() async {
    turnBusy();
    final _activity = await _activityservice.getactivity();
    if (_activity == null) return null;
    turnIdle();
    // todayDate(_activity);
    _activity.sort((a, b) {
      var adate = a.date; //before -> var adate = a.expiry;
      var bdate = b.date; //var bdate = b.expiry;
      return adate.compareTo(bdate);
    });
    return _activity;
  }
}
