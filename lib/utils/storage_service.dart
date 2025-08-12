import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';

  static Future<void> saveUserData(String id, String name, String email) async {
    try {
      if (kIsWeb) {
        // Usa localStorage per il web
        html.window.localStorage[_userIdKey] = id;
        html.window.localStorage[_userNameKey] = name;
        html.window.localStorage[_userEmailKey] = email;
        print('DEBUG: Data saved to localStorage - id: $id, name: $name, email: $email');
      } else {
        // Usa SharedPreferences per mobile
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userIdKey, id);
        await prefs.setString(_userNameKey, name);
        await prefs.setString(_userEmailKey, email);
        print('DEBUG: Data saved to SharedPreferences - id: $id, name: $name, email: $email');
      }
    } catch (e) {
      print('DEBUG: Error saving user data: $e');
    }
  }

  static Future<Map<String, String>?> getUserData() async {
    try {
      if (kIsWeb) {
        // Recupera da localStorage per il web
        final id = html.window.localStorage[_userIdKey];
        final name = html.window.localStorage[_userNameKey];
        final email = html.window.localStorage[_userEmailKey];
        print('DEBUG: Retrieved from localStorage - id: $id, name: $name, email: $email');
        
        if (id != null && id.isNotEmpty && name != null && name.isNotEmpty && email != null && email.isNotEmpty) {
          return {
            'id': id,
            'name': name,
            'email': email,
          };
        }
      } else {
        // Recupera da SharedPreferences per mobile
        final prefs = await SharedPreferences.getInstance();
        final id = prefs.getString(_userIdKey);
        final name = prefs.getString(_userNameKey);
        final email = prefs.getString(_userEmailKey);
        print('DEBUG: Retrieved from SharedPreferences - id: $id, name: $name, email: $email');
        
        if (id != null && id.isNotEmpty && name != null && name.isNotEmpty && email != null && email.isNotEmpty) {
          return {
            'id': id,
            'name': name,
            'email': email,
          };
        }
      }
      return null;
    } catch (e) {
      print('DEBUG: Error getting user data: $e');
      return null;
    }
  }

  static Future<void> clearUserData() async {
    try {
      if (kIsWeb) {
        // Cancella da localStorage per il web
        html.window.localStorage.remove(_userIdKey);
        html.window.localStorage.remove(_userNameKey);
        html.window.localStorage.remove(_userEmailKey);
        print('DEBUG: User data cleared from localStorage');
      } else {
        // Cancella da SharedPreferences per mobile
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(_userIdKey);
        await prefs.remove(_userNameKey);
        await prefs.remove(_userEmailKey);
        print('DEBUG: User data cleared from SharedPreferences');
      }
    } catch (e) {
      print('DEBUG: Error clearing user data: $e');
    }
  }

  // Metodi generici per salvare/recuperare dati
  static Future<void> saveData(String key, Map<String, dynamic> data) async {
    try {
      final jsonString = jsonEncode(data);
      if (kIsWeb) {
        html.window.localStorage[key] = jsonString;
        print('DEBUG: Data saved to localStorage with key: $key');
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(key, jsonString);
        print('DEBUG: Data saved to SharedPreferences with key: $key');
      }
    } catch (e) {
      print('DEBUG: Error saving data with key $key: $e');
    }
  }

  static Future<Map<String, dynamic>?> getData(String key) async {
    try {
      String? jsonString;
      if (kIsWeb) {
        jsonString = html.window.localStorage[key];
        print('DEBUG: Data retrieved from localStorage with key: $key');
      } else {
        final prefs = await SharedPreferences.getInstance();
        jsonString = prefs.getString(key);
        print('DEBUG: Data retrieved from SharedPreferences with key: $key');
      }
      
      if (jsonString != null && jsonString.isNotEmpty) {
        try {
          final decoded = jsonDecode(jsonString);
          if (decoded is Map<String, dynamic>) {
            return decoded;
          }
        } catch (e) {
          print('DEBUG: Error parsing JSON for key $key: $e');
        }
      }
      return null;
    } catch (e) {
      print('DEBUG: Error getting data with key $key: $e');
      return null;
    }
  }

  static Future<void> clearData(String key) async {
    try {
      if (kIsWeb) {
        html.window.localStorage.remove(key);
        print('DEBUG: Data cleared from localStorage with key: $key');
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(key);
        print('DEBUG: Data cleared from SharedPreferences with key: $key');
      }
    } catch (e) {
      print('DEBUG: Error clearing data with key $key: $e');
    }
  }
}