class Chat {
  dynamic
      _id; // Use dynamic type because json-server id is int and firestore id is string
  dynamic
      _uid; // Use dynamic type because json-server id is int and firestore id is string
  String _name;
  String _chat;
  String _date;

  // ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  // ignore: unnecessary_getters_setters
  get uid => _uid;
  // ignore: unnecessary_getters_setters
  set uid(value) => _uid = value;

  get name => _name;
  set name(value) => _name = value;

  get chat => _chat;
  set chat(value) => _chat = value;

  get date => _date;
  set date(value) => _date = value;

  Chat(
      {dynamic id,
      dynamic uid,
      String name = '',
      String chat = '',
      String date = ''})
      : _id = id,
        _uid = uid,
        _name = name,
        _chat = chat,
        _date = date;

  Chat.copy(Chat from)
      : this(
            id: from.id,
            uid: from.uid,
            name: from.name,
            chat: from.chat,
            date: from.date);

  Chat.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            uid: json['uid'],
            name: json['name'],
            chat: json['chat'],
            date: json['date']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'chat': chat,
        'date': date,
      };
}
