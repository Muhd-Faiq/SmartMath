import 'package:smartmath/models/activity.dart';

import '../../models/activity.dart';

abstract class ActivityService {
  Future<List<Activity>> getactivity();
  Future<Activity> createnewactivity({Activity activity});
}
