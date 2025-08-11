import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:arrowclash/bloc/auth_bloc.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/utils/app_localizations.dart';
import 'package:arrowclash/screens/splash_screen.dart';
import 'package:arrowclash/screens/login_screen.dart';
import 'package:arrowclash/screens/home_screen.dart';
import 'package:arrowclash/screens/game_selection_screen.dart';
import 'package:arrowclash/screens/game_rules_screen.dart';
import 'package:arrowclash/screens/game_setup_screen.dart';
import 'package:arrowclash/screens/game_screen.dart';
import 'package:arrowclash/screens/results_screen.dart';
import 'package:arrowclash/screens/stats_screen.dart';
import 'package:arrowclash/screens/profile_screen.dart';
import 'package:arrowclash/screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String languageCode = await AppLocalizations.getLocale();
  runApp(ArrowClashApp(languageCode: languageCode));
}

class ArrowClashApp extends StatelessWidget {
  final String languageCode;
  
  const ArrowClashApp({Key? key, required this.languageCode}) : super(key: key);

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
        title: 'ArrowClash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('it'),
        ],
        locale: Locale(languageCode),
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
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
