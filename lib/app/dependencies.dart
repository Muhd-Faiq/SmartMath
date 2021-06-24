import 'package:get_it/get_it.dart';

import '../services/rest.dart';
import '../services/userviewmodel.dart';
import '../services/listuserviewmodel.dart';
import '../services/activityviewmodel.dart';
import '../services/submissionviewmodel.dart';
import '../services/studentviewmodel.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/auth_service_rest.dart';
import '../services/chat/chat_service.dart';
import '../services/chat/chat_service_rest.dart';
import '../services/activity/activity_service.dart';
import '../services/activity/activity_service_rest.dart';
import '../services/submission/submission_service_rest.dart';
import '../services/submission/submission_service.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(
        baseUrl:
            'https://us-central1-smartmathturtledevs.cloudfunctions.net/api'),
  );

  dependency.registerLazySingleton<AuthService>(() => AuthServiceRest());
  dependency
      .registerLazySingleton<ActivityService>(() => ActivityServiceRest());
  dependency
      .registerLazySingleton<SubmissionService>(() => SubmissionServiceRest());
  dependency.registerLazySingleton<ChatService>(() => ChatServiceRest());
  // dependency.registerLazySingleton<AuthService>(() => AuthServiceMock());

  // Viewmodels
  dependency.registerLazySingleton(() => UserViewmodel());
  dependency.registerLazySingleton(() => StudentViewmodel());
  dependency.registerLazySingleton(() => ListUserViewmodel());
  dependency.registerLazySingleton(() => ActivityViewmodel());
  dependency.registerLazySingleton(() => SubmissionViewmodel());
}
