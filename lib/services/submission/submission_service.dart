import '../../models/submission.dart';

abstract class SubmissionService {
  Future<Submission> getSubmission({String aid, String uid});
  Future<List<Submission>> getActvitySubmission({String aid});
  Future<Submission> createnewsubmission({Submission submission});
  Future<Submission> updateSubmission({Submission submission});
}
