import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/game_selection_screen.dart';
import '../screens/game_rules_screen.dart';
import '../screens/game_setup_screen.dart';
import '../screens/game_screen.dart';
import '../screens/results_screen.dart';
import '../screens/stats_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/forgot_password_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case '/game_selection':
            return MaterialPageRoute(builder: (_) => const GameSelectionScreen());
          case '/game_rules':
            return MaterialPageRoute(builder: (_) => const GameRulesScreen());
          case '/game_setup':
            return MaterialPageRoute(builder: (_) => const GameSetupScreen());
          case '/game':
            return MaterialPageRoute(builder: (_) => const GameScreen());
          case '/results':
            return MaterialPageRoute(builder: (_) => const ResultsScreen());
          case '/stats':
            return MaterialPageRoute(builder: (_) => const StatsScreen());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfileScreen());
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
          case '/forgot-password':
            return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}