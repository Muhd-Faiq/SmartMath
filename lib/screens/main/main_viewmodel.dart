import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../models/user.dart';
import '../viewmodel.dart';

class MainViewmodel extends Viewmodel {
  MainViewmodel(User tempuser) {
    _user = tempuser;
  }
  AuthService get _service => dependency();
  User _user = User();
  // User _tempuser;

  bool _showPassword = false;
  bool _showErrorMessage = false;

  get user => _user;
  set user(value) => _user = value;

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
      ),
    );
    if (result == null) _showErrorMessage = true;
    turnIdle();
    return _user;
  }
}
