// App constants

class AppConstants {
  // App information
  static const String appName = 'Archery Race';
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
    'duo': 'Mixed team: beginner + veteran',
    'classica': 'Classic archery game',
    'bull': 'Bull\'s eye challenge',
    'impact': 'Target impact game',
    'solo': 'Individual 18m game',
  };
  
  // Error messages
  static const String networkError = 'Network error occurred. Please try again.';
  static const String authenticationError = 'Authentication failed. Please check your credentials.';
  static const String unknownError = 'An unknown error occurred. Please try again.';
  static const String noDataError = 'No data available.';
  
  // Success messages
  static const String loginSuccess = 'Login successful!';
  static const String registrationSuccess = 'Registration successful!';
  static const String gameSavedSuccess = 'Game results saved successfully!';
  static const String logoutSuccess = 'You have been logged out successfully!';
}