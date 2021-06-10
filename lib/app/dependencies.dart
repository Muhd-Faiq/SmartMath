import 'package:get_it/get_it.dart';

import '../services/rest.dart';
import '../services/auth/auth_service.dart';
import '../services/auth/auth_service_rest.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(
        baseUrl:
            'https://us-central1-smartmathturtledevs.cloudfunctions.net/api'),
  );

  dependency.registerLazySingleton<AuthService>(() => AuthServiceRest());
  // dependency.registerLazySingleton<CounterService>(() => CounterServiceMock());
  // dependency.registerLazySingleton<AuthService>(() => AuthServiceMock());

  // Viewmodels
  // dependency.registerLazySingleton(() => UserViewmodel());
}
