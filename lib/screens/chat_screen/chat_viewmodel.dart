import 'package:intl/intl.dart';

import '../../app/dependencies.dart';
import '../../services/auth/auth_service.dart';
import '../../services/chat/chat_service.dart';
import '../../models/user.dart';
import '../../models/chat.dart';
import '../viewmodel.dart';
import '../../services/userviewmodel.dart';

class ChatViewmodel extends Viewmodel {
  AuthService get _service => dependency();
  ChatService get _chatservice => dependency();
  UserViewmodel get _userdependency => dependency();
  User _user = User();
  List<Chat> _listactivity;
  Future<List<Chat>> _futurelistactivity;

  get user => _userdependency.user;
  set user(value) => _userdependency.user = value;

  get listactivity => _listactivity;
  set listactivity(value) => _listactivity = value;

  get futurelistactivity => _futurelistactivity;
  set futurelistactivity(value) => _futurelistactivity = value;

  String _chat;
  get chat => _chat;
  set chat(value) {
    turnBusy();
    _chat = value;
    turnIdle();
  }

  Future<List<Chat>> getchat() async {
    turnBusy();
    final _chatlist = await _chatservice.getchat();
    if (_chatlist == null) return null;
    turnIdle();
    // _listuserdependency.listuser = _chatlist;
    _chatlist.sort((a, b) {
      var adate = a.date; //before -> var adate = a.expiry;
      var bdate = b.date; //var bdate = b.expiry;
      return -adate.compareTo(bdate);
    });
    return _chatlist;
  }

  Future<Chat> createnewchat() async {
    turnBusy();
    final result = await _chatservice.createnewchat(
      chat: Chat(
        uid: user.id,
        name: user.name,
        date: DateFormat("yyyy-MM-dd hh:mm:ss aa").format(DateTime.now()),
        chat: chat,
      ),
    );
    // if (result == null) _showErrorMessage = true;
    turnIdle();
    if (result != null) {
      listactivity.add(result);
      _listactivity.sort((a, b) {
        var adate = a.date; //before -> var adate = a.expiry;
        var bdate = b.date; //var bdate = b.expiry;
        return -adate.compareTo(bdate);
      });
      return result;
    }

    return null;
  }
}
