import '../../app/dependencies.dart';
import '../../models/chat.dart';
import '../rest.dart';
import 'chat_service.dart';

class ChatServiceRest implements ChatService {
  RestService get rest => dependency();

  Future<List<Chat>> getchat() async {
    String temp = 'chat';
    final List json = await rest.get(temp);
    if (json == null || json.length == 0) return null;
    print(temp);
    print(json.length);
    return json.map((jsonItem) => Chat.fromJson(jsonItem)).toList();
  }

  Future<Chat> createnewchat({Chat chat}) async {
    final json = await rest.post('chat/', data: chat);
    if (json == null || json.length == 0) return null;

    final _user = Chat.fromJson(json);
    return _user;
  }
}
