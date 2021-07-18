import '../../app/dependencies.dart';
import '../../models/submission.dart';
import '../rest.dart';
import 'submission_service.dart';

class SubmissionServiceRest implements SubmissionService {
  RestService get rest => dependency();

  Future<Submission> getSubmission({String aid, String uid}) async {
    String temp = 'submission?aid=$aid&&uid=$uid';
    final List json = await rest.get(temp);
    if (json == null || json.length == 0) return null;
    final _submission = Submission.fromJson(json[0]);
    return _submission;
  }

  Future<List<Submission>> getActvitySubmission({String aid}) async {
    String temp = 'submission?aid=$aid';
    final List json = await rest.get(temp);
    if (json == null || json.length == 0) return null;
    final _submission = json.map((e) => Submission.fromJson(e)).toList();
    return _submission;
  }

  Future<Submission> createnewsubmission({Submission submission}) async {
    final json = await rest.post('submission/', data: submission);
    if (json == null || json.length == 0) return null;

    final _submission = Submission.fromJson(json);
    return _submission;
  }

  Future<Submission> updateSubmission({Submission submission}) async {
    final json =
        await rest.patch('submission/${submission.id}', data: submission);
    if (json == null || json.length == 0) return null;

    final _submission = Submission.fromJson(json);
    return _submission;
  }
}
