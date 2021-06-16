import '../../app/dependencies.dart';
import '../../models/activity.dart';
import '../rest.dart';
import 'activity_service.dart';

class ActivityServiceRest implements ActivityService {
  RestService get rest => dependency();

  // Future<Activity> authenticate({String login, String password}) async {
  //   String temp = 'users?login=$login&&password=$password';
  //   final List json = await rest.get(temp);
  //   if (json == null || json.length == 0) return null;
  //   print(temp);
  //   print(json.length);
  //   final _user = Activity.fromJson(json[0]);
  //   return _user;
  // }

  Future<Activity> createnewactivity({Activity activity}) async {
    final json = await rest.post('activity/', data: activity);
    if (json == null || json.length == 0) return null;

    final _user = Activity.fromJson(json);
    return _user;
  }

  // Future<User> updateUser({User user}) async {
  //   print('id: ${user.id}');
  //   final json = await rest.patch('users/${user.id}', data: user);
  //   if (json == null || json.length == 0) return null;

  //   final _user = User.fromJson(json);
  //   return _user;
  // }
}
