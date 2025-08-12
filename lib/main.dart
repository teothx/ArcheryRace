import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:arrowclash/bloc/auth_bloc.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/bloc/connectivity_bloc.dart';
import 'package:arrowclash/utils/supabase_config.dart';
import 'package:arrowclash/utils/app_router.dart';
import 'package:arrowclash/widgets/connectivity_banner.dart';
import 'package:arrowclash/l10n/app_localizations.dart';
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
import 'package:arrowclash/screens/forgot_password_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inizializza Supabase
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );
  
  String languageCode = 'en'; // Default fallback
  
  if (kIsWeb) {
    // Per il web, usa il default 'en' o 'it' basato su una logica semplice
    languageCode = 'en';
  } else {
    // Per mobile, usa Platform.localeName
    try {
      languageCode = Platform.localeName.split('_')[0];
    } catch (e) {
      languageCode = 'en';
    }
  }
  
  runApp(ArrowClashApp(languageCode: languageCode));
}

class ArrowClashApp extends StatelessWidget {
  final String languageCode;

  const ArrowClashApp({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppLocalizations>(
      future: AppLocalizations.delegate.load(Locale(languageCode)),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final localizations = snapshot.data!;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(localizations: localizations)..add(CheckAuthStatus()),
            ),
            BlocProvider(
              create: (context) => GameBloc(),
            ),
            BlocProvider(
              create: (context) => ConnectivityBloc()..add(CheckConnectivity()),
            ),
          ],
          child: MaterialApp(
            title: 'ArrowClash',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(languageCode),
            builder: (context, child) {
              return ConnectivityBanner(child: child!);
            },
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
                  return MaterialPageRoute(
                    builder: (_) => const GameRulesScreen(),
                    settings: settings,
                  );
                case '/game_setup':
                  return MaterialPageRoute(
                    builder: (_) => const GameSetupScreen(),
                    settings: settings,
                  );
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
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
