import '../../models/chat.dart';

abstract class ChatService {
  Future<List<Chat>> getchat();
  Future<Chat> createnewchat({Chat chat});
}
