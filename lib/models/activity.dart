import 'package:intl/intl.dart';

class Activity {
  dynamic
      _id; // Use dynamic type because json-server id is int and firestore id is string
  String _title;
  String _description;
  String _file;
  String _category;
  dynamic _uid;
  String _date;
  String _tutorialdate;

  // ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  get title => _title;
  set title(value) => _title = value;

  get description => _description;
  set description(value) => _description = value;

  get file => _file;
  set file(value) => _file = value;

  get category => _category;
  set category(value) => _category = value;

  // ignore: unnecessary_getters_setters
  get uid => _uid;
  // ignore: unnecessary_getters_setters
  set uid(value) => _uid = value;

  get date => _date;
  set date(value) => _date = value;

  get tutorialdate => _tutorialdate;
  set tutorialdate(value) => _tutorialdate = value;

  Activity(
      {dynamic id,
      String title = '',
      String description = '',
      String file = '',
      String category = 'Tutorial',
      dynamic uid,
      String date,
      String tutorialdate})
      : _id = id,
        _title = title,
        _description = description,
        _file = file,
        _category = category,
        _uid = uid,
        _date = date,
        _tutorialdate = tutorialdate;

  Activity.copy(Activity from)
      : this(
            id: from.id,
            title: from.title,
            description: from.description,
            file: from.file,
            category: from.category,
            uid: from.uid,
            date: from.date,
            tutorialdate: from.tutorialdate);

  Activity.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            file: json['file'],
            category: json['category'],
            uid: json['uid'],
            date: json['date'],
            tutorialdate: json['tutorialdate']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'file': file,
        'category': category,
        'uid': uid,
        'date': date,
        'tutorialdate': tutorialdate
      };
}
