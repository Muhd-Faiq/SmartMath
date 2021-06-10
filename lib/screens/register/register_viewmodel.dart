import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../models/user.dart';
import '../viewmodel.dart';

class RegisterViewmodel extends Viewmodel {
  AuthService get _service => dependency();
  User _user = User();
  // bool _showPassword = false;
  bool _showErrorMessage = false;

  get user => _user;
  set user(value) => _user = value;

  // get showPassword => _showPassword;
  // set showPassword(value) {
  //   turnBusy();
  //   _showPassword = value;
  //   turnIdle();
  // }

  get name => _user.name;
  set name(value) {
    turnBusy();
    _showErrorMessage = false;
    _user.name = value;
    turnIdle();
  }

  get login => _user.login;
  set login(value) {
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

  // get password2 => _user.password2;
  set password2(value) {
    if (value == password) {
      turnBusy();
      _showErrorMessage = false;
      turnIdle();
    } else {
      _showErrorMessage = true;
    }
  }

  get showErrorMessage => _showErrorMessage;
  set showErrorMessage(value) {
    turnBusy();
    _showErrorMessage = value;
    turnIdle();
  }

  Future<User> register() async {
    turnBusy();
    final result = await _service.register(
      user: User(
        login: user.login,
        name: user.name,
        password: user.password,
      ),
    );
    if (result == null) _showErrorMessage = true;
    turnIdle();
    return _user;
  }
}
