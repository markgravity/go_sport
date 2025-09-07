import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// GetIt dependency injection
import 'core/dependency_injection/injection_container.dart';
// AutoRoute app
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize GetIt dependency injection
  await configureDependencies();

  runApp(
    const GoSportApp(), // Using Cubit/Bloc only
  );
}