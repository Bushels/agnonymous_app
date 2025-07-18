import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  static late String _supabaseUrl;
  static late String _supabaseAnonKey;
  
  static String get supabaseUrl => _supabaseUrl;
  static String get supabaseAnonKey => _supabaseAnonKey;
  
  static Future<void> initialize() async {
    try {
      if (kIsWeb) {
        // For web, use hardcoded values or environment-specific config
        // In production, these should come from environment variables set during build
        _supabaseUrl = const String.fromEnvironment(
          'SUPABASE_URL',
          defaultValue: 'https://ibgsloyjxdopkvwqcqwh.supabase.co',
        );
        _supabaseAnonKey = const String.fromEnvironment(
          'SUPABASE_ANON_KEY', 
          defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImliZ3Nsb3lqeGRvcGt2d3FjcXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2ODYzMzksImV4cCI6MjA2ODI2MjMzOX0.Ik1980vz4s_UxVuEfBm61-kcIzEH-Nt-hQtydZUeNTw',
        );
      } else {
        // For mobile/desktop, load from .env file
        await dotenv.load(fileName: ".env");
        
        _supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
        _supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
      }
      
      print('Platform: ${kIsWeb ? "Web" : "Native"}');
      print('Supabase URL: $_supabaseUrl');
      print('Supabase Key exists: ${_supabaseAnonKey.isNotEmpty}');
      
      if (_supabaseUrl.isEmpty || _supabaseAnonKey.isEmpty) {
        throw Exception('Missing Supabase configuration');
      }
      
      await Supabase.initialize(
        url: _supabaseUrl,
        anonKey: _supabaseAnonKey,
      );
    } catch (e) {
      print('Error initializing app config: $e');
      rethrow;
    }
  }
}