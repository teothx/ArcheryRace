import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archery_race/bloc/auth_bloc.dart';
import 'package:archery_race/bloc/game_bloc.dart';
import 'package:archery_race/screens/splash_screen.dart';
import 'package:archery_race/screens/login_screen.dart';
import 'package:archery_race/screens/home_screen.dart';
import 'package:archery_race/screens/game_selection_screen.dart';
import 'package:archery_race/screens/game_rules_screen.dart';
import 'package:archery_race/screens/game_setup_screen.dart';
import 'package:archery_race/screens/game_screen.dart';
import 'package:archery_race/screens/results_screen.dart';
import 'package:archery_race/screens/stats_screen.dart';
import 'package:archery_race/screens/profile_screen.dart';

void main() {
  runApp(const ArcheryRaceApp());
}

class ArcheryRaceApp extends StatelessWidget {
  const ArcheryRaceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(CheckAuthStatus()),
        ),
        BlocProvider(
          create: (context) => GameBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Archery Race',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/game_selection': (context) => const GameSelectionScreen(),
          '/game_rules': (context) => const GameRulesScreen(),
          '/game_setup': (context) => const GameSetupScreen(),
          '/game': (context) => const GameScreen(),
          '/results': (context) => const ResultsScreen(),
          '/stats': (context) => const StatsScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}