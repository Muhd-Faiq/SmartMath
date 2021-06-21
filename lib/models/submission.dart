import 'package:intl/intl.dart';

class Submission {
  dynamic _id;
  String _comment;
  String _filesubmit;
  dynamic _uid;
  dynamic _aid;
  String _datesubmit;

  // ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  get comment => _comment;
  set comment(value) => _comment = value;

  get filesubmit => _filesubmit;
  set filesubmit(value) => _filesubmit = value;

  // ignore: unnecessary_getters_setters
  get uid => _uid;
  // ignore: unnecessary_getters_setters
  set uid(value) => _uid = value;

  // ignore: unnecessary_getters_setters
  get aid => _aid;
  // ignore: unnecessary_getters_setters
  set aid(value) => _aid = value;

  get datesubmit => _datesubmit;
  set datesubmit(value) => _datesubmit = value;

  Submission(
      {dynamic id,
      String comment,
      String filesubmit,
      dynamic uid,
      dynamic aid,
      String datesubmit})
      : _id = id,
        _comment = comment,
        _filesubmit = filesubmit,
        _uid = uid,
        _aid = aid,
        _datesubmit = datesubmit;

  Submission.copy(Submission from)
      : this(
            id: from.id,
            comment: from.comment,
            filesubmit: from.filesubmit,
            uid: from.uid,
            aid: from.aid,
            datesubmit: from.datesubmit);

  Submission.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            comment: json['comment'],
            filesubmit: json['filesubmit'],
            uid: json['uid'],
            aid: json['aid'],
            datesubmit: json['datesubmit']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'comment': comment,
        'filesubmit': filesubmit,
        'uid': uid,
        'aid': aid,
        'datesubmit': datesubmit
      };
}
