import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://btruihnshwgeyfarnoxn.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ0cnVpaG5zaHdnZXlmYXJub3huIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5NDMzNzQsImV4cCI6MjA3MDUxOTM3NH0.DmUlVSWN6N5-lvXf_08jAmgpW4ngzOXFT3vGqMXhCd8';
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
}