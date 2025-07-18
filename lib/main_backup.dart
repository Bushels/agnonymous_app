import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Global error handling
  FlutterError.onError = (details) {
    // Log to crash reporting service
    debugPrint('Flutter error: ${details.exception}');
  };
  
  try {
    await AppConfig.initialize();
    await _initializeAuth();
  } catch (e) {
    debugPrint('Initialization error: $e');
    // Show error screen
  }
  
  runApp(const ProviderScope(child: AgnonymousApp()));
}

Future<void> _initializeAuth() async {
  final supabase = Supabase.instance.client;
  
  // Try anonymous auth with retry
  int retries = 3;
  while (retries > 0) {
    try {
      if (supabase.auth.currentUser == null) {
        await supabase.auth.signInAnonymously();
      }
      break;
    } catch (e) {
      retries--;
      if (retries == 0) rethrow;
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}

class AgnonymousApp extends StatelessWidget {
  const AgnonymousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agnonymous',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}