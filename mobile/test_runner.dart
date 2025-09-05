#!/usr/bin/env dart
// Test runner script for Go Sport mobile app
// Run with: dart test_runner.dart

import 'dart:io';

void main(List<String> arguments) async {
  print('🧪 Go Sport Mobile App Test Runner');
  print('================================');
  
  final stopwatch = Stopwatch()..start();
  
  try {
    // Check if we're in the mobile directory
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) {
      print('❌ Error: pubspec.yaml not found. Please run from the mobile app directory.');
      exit(1);
    }
    
    // Get dependencies first
    print('\n📦 Getting dependencies...');
    final pubGetResult = await Process.run('flutter', ['pub', 'get']);
    if (pubGetResult.exitCode != 0) {
      print('❌ Failed to get dependencies');
      print(pubGetResult.stderr);
      exit(1);
    }
    print('✅ Dependencies updated');
    
    // Run different test categories based on arguments
    if (arguments.isEmpty || arguments.contains('all')) {
      await runAllTests();
    } else {
      for (final arg in arguments) {
        switch (arg) {
          case 'unit':
            await runUnitTests();
            break;
          case 'widget':
            await runWidgetTests();
            break;
          case 'integration':
            await runIntegrationTests();
            break;
          case 'coverage':
            await runTestsWithCoverage();
            break;
          default:
            print('❓ Unknown test category: $arg');
            printUsage();
            break;
        }
      }
    }
    
  } catch (e) {
    print('❌ Error running tests: $e');
    exit(1);
  } finally {
    stopwatch.stop();
    print('\n⏱️  Total time: ${stopwatch.elapsed.inSeconds}s');
  }
}

Future<void> runAllTests() async {
  print('\n🔍 Running all tests...');
  
  final testResult = await Process.run('flutter', ['test']);
  
  if (testResult.exitCode == 0) {
    print('✅ All tests passed!');
    print(testResult.stdout);
  } else {
    print('❌ Some tests failed:');
    print(testResult.stdout);
    print(testResult.stderr);
    exit(1);
  }
}

Future<void> runUnitTests() async {
  print('\n🧪 Running unit tests...');
  
  final unitTests = [
    'test/core/utils/phone_validator_test.dart',
    'test/core/services/sports_localization_service_test.dart',
    'test/features/auth/services/phone_auth_service_test.dart',
  ];
  
  for (final testFile in unitTests) {
    if (await File(testFile).exists()) {
      print('  Running: $testFile');
      final result = await Process.run('flutter', ['test', testFile]);
      if (result.exitCode != 0) {
        print('  ❌ Failed: $testFile');
        print(result.stderr);
        exit(1);
      } else {
        print('  ✅ Passed: $testFile');
      }
    } else {
      print('  ⚠️  Not found: $testFile');
    }
  }
  
  print('✅ Unit tests completed');
}

Future<void> runWidgetTests() async {
  print('\n🎨 Running widget tests...');
  
  final widgetTests = [
    'test/features/auth/screens/phone_registration_screen_test.dart',
    'test/features/auth/screens/sms_verification_screen_test.dart',
  ];
  
  for (final testFile in widgetTests) {
    if (await File(testFile).exists()) {
      print('  Running: $testFile');
      final result = await Process.run('flutter', ['test', testFile]);
      if (result.exitCode != 0) {
        print('  ❌ Failed: $testFile');
        print(result.stderr);
        exit(1);
      } else {
        print('  ✅ Passed: $testFile');
      }
    } else {
      print('  ⚠️  Not found: $testFile');
    }
  }
  
  print('✅ Widget tests completed');
}

Future<void> runIntegrationTests() async {
  print('\n🔗 Running integration tests...');
  
  final integrationTests = [
    'test/features/auth/integration/sms_verification_integration_test.dart',
  ];
  
  for (final testFile in integrationTests) {
    if (await File(testFile).exists()) {
      print('  Running: $testFile');
      final result = await Process.run('flutter', ['test', testFile]);
      if (result.exitCode != 0) {
        print('  ❌ Failed: $testFile');
        print(result.stderr);
        exit(1);
      } else {
        print('  ✅ Passed: $testFile');
      }
    } else {
      print('  ⚠️  Not found: $testFile');
    }
  }
  
  print('✅ Integration tests completed');
}

Future<void> runTestsWithCoverage() async {
  print('\n📊 Running tests with coverage...');
  
  final result = await Process.run('flutter', [
    'test', 
    '--coverage',
    '--reporter=expanded'
  ]);
  
  if (result.exitCode == 0) {
    print('✅ Tests with coverage completed!');
    print(result.stdout);
    
    // Try to generate coverage report if lcov is available
    try {
      final lcovResult = await Process.run('genhtml', [
        'coverage/lcov.info',
        '-o',
        'coverage/html'
      ]);
      
      if (lcovResult.exitCode == 0) {
        print('📊 Coverage report generated at: coverage/html/index.html');
      }
    } catch (e) {
      print('ℹ️  Install lcov to generate HTML coverage reports');
    }
  } else {
    print('❌ Coverage test failed:');
    print(result.stdout);
    print(result.stderr);
    exit(1);
  }
}

void printUsage() {
  print('\nUsage: dart test_runner.dart [category]');
  print('');
  print('Categories:');
  print('  all         Run all tests (default)');
  print('  unit        Run unit tests only');
  print('  widget      Run widget tests only');
  print('  integration Run integration tests only');
  print('  coverage    Run tests with coverage report');
  print('');
  print('Examples:');
  print('  dart test_runner.dart');
  print('  dart test_runner.dart unit');
  print('  dart test_runner.dart widget integration');
  print('  dart test_runner.dart coverage');
}