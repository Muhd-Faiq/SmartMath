import '../../models/user.dart';

abstract class AuthService {
  Future<User> authenticate({String login, String password});
  Future<List<User>> getalluser({String role});
  Future<User> register({User user});
  Future<User> updateUser({User user});
}
