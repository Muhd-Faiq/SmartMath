import '../../app/dependencies.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'auth_service.dart';

class AuthServiceRest implements AuthService {
  RestService get rest => dependency();

  Future<User> authenticate({String login, String password}) async {
    String temp = 'users?login=$login&&password=$password';
    final List json = await rest.get(temp);
    if (json == null || json.length == 0) return null;
    print(temp);
    print(json.length);
    final _user = User.fromJson(json[0]);
    return _user;
  }

  Future<List<User>> getalluser({String role}) async {
    String temp = 'users?role=$role';
    final List json = await rest.get(temp);
    if (json == null || json.length == 0) return null;
    print(temp);
    print(json.length);
    final _user = json.map((e) => User.fromJson(e)).toList();
    return _user;
  }

  Future<User> register({User user}) async {
    final json = await rest.post('users/', data: user);
    if (json == null || json.length == 0) return null;

    final _user = User.fromJson(json);
    return _user;
  }

  Future<User> updateUser({User user}) async {
    print('id: ${user.id}');
    final json = await rest.patch('users/${user.id}', data: user);
    if (json == null || json.length == 0) return null;

    final _user = User.fromJson(json);
    return _user;
  }
}
// Future<Counter> updateCounter(Counter counter) async {
//   final json = await rest.put('counters/${counter.id}', data: counter);
//   return Counter.fromJson(json);
// }
