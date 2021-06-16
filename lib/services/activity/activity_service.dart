import 'package:smartmath/models/activity.dart';

import '../../models/activity.dart';

abstract class ActivityService {
  Future<Activity> createnewactivity({Activity activity});
}
