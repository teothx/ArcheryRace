import 'package:flutter/material.dart';
import 'package:archery_race/screens/splash_screen.dart';
import 'package:archery_race/screens/login_screen.dart';
import 'package:archery_race/screens/home_screen.dart';
import 'package:archery_race/screens/game_selection_screen.dart';
import 'package:archery_race/screens/game_rules_screen.dart';
import 'package:archery_race/screens/game_setup_screen.dart';
import 'package:archery_race/screens/game_screen.dart';
import 'package:archery_race/screens/results_screen.dart';
import 'package:archery_race/screens/stats_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String gameSelection = '/game_selection';
  static const String gameRules = '/game_rules';
  static const String gameSetup = '/game_setup';
  static const String game = '/game';
  static const String results = '/results';
  static const String stats = '/stats';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case gameSelection:
        return MaterialPageRoute(
          builder: (_) => const GameSelectionScreen(),
          settings: settings,
        );
      case gameRules:
        final gameType = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => GameRulesScreen(),
          settings: settings,
        );
      case gameSetup:
        return MaterialPageRoute(
          builder: (_) => const GameSetupScreen(),
          settings: settings,
        );
      case game:
        return MaterialPageRoute(
          builder: (_) => const GameScreen(),
          settings: settings,
        );
      case results:
        return MaterialPageRoute(
          builder: (_) => const ResultsScreen(),
          settings: settings,
        );
      case stats:
        return MaterialPageRoute(
          builder: (_) => const StatsScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}