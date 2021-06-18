import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'app/dependencies.dart' as di;
import 'app/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );

  await Firebase.initializeApp();
  di.init();

  runApp(
    MaterialApp(
      title: 'MVVM Template',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      onGenerateRoute: createRoute,
    ),
  );
}
