// App constants
import 'package:flutter/material.dart';

class AppConstants {
  // App information
  static const String appName = 'ArrowClash';
  static const String appVersion = '1.0.0';
  
  // SharedPreferences keys
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userNameKey = 'name';
  static const String userEmailKey = 'email';
  static const String gameHistoryKey = 'gameHistory';
  
  // Score values
  static const int minScore = 0;
  static const int maxScore = 10;
  static const int missScore = 0;
  static const String missValue = 'M';
  
  // Game configuration limits
  static const int minParticipants = 1;
  static const int maxParticipants = 20;
  static const int minVolleys = 2;
  static const int maxVolleys = 10;
  
  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Padding and margin values
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  // Border radius values
  static const double smallBorderRadius = 4.0;
  static const double mediumBorderRadius = 8.0;
  static const double largeBorderRadius = 12.0;
  static const double extraLargeBorderRadius = 16.0;
  
  // Font sizes
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 16.0;
  static const double largeFontSize = 20.0;
  static const double extraLargeFontSize = 24.0;
  static const double titleFontSize = 32.0;
  
  // Icon sizes
  static const double smallIconSize = 16.0;
  static const double mediumIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;
  
  // Chart colors
  static const List<Color> chartColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.amber,
    Colors.indigo,
  ];
  
  // Game type specific messages
  static const Map<String, String> gameTypeMessages = {
    'duo': 'Squadra mista: principiante + veterano',
    'classica': 'Gioco classico di tiro con l\'arco',
    'bull': 'Sfida al centro del bersaglio',
    'impact': 'Gioco di impatto sul bersaglio',
    'solo': 'Gioco individuale 18m',
  };
  
  // Error messages
  static const String networkError = 'Errore di rete. Riprova più tardi.';
  static const String authenticationError = 'Autenticazione fallita. Controlla le tue credenziali.';
  static const String unknownError = 'Si è verificato un errore sconosciuto. Riprova.';
  static const String noDataError = 'Nessun dato disponibile.';
  
  // Success messages
  static const String loginSuccess = 'Login effettuato con successo!';
  static const String registrationSuccess = 'Registrazione completata con successo!';
  static const String gameSavedSuccess = 'Risultati del gioco salvati con successo!';
  static const String logoutSuccess = 'Sei stato disconnesso con successo!';
}