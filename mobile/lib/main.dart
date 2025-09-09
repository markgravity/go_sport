import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mcp_toolkit/mcp_toolkit.dart';
import 'firebase_options.dart';
// GetIt dependency injection
import 'core/dependency_injection/injection_container.dart';
// AutoRoute app
import 'app/app.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize MCP Toolkit
      MCPToolkitBinding.instance
        ..initialize()
        ..initializeFlutterToolkit();

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
    },
    (error, stack) {
      MCPToolkitBinding.instance.handleZoneError(error, stack);
    },
  );
}