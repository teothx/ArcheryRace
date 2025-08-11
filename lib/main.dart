import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:arrowclash/bloc/auth_bloc.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/utils/supabase_config.dart';
import 'package:arrowclash/utils/app_router.dart';
import 'package:arrowclash/l10n/app_localizations.dart';

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
  
  const ArrowClashApp({Key? key, required this.languageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Builder(
        builder: (context) {
          final localizations = AppLocalizations.of(context)!;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthBloc(localizations: localizations)..add(CheckAuthStatus()),
              ),
              BlocProvider(
                create: (context) => GameBloc(),
              ),
            ],
            child: const AppRouter(),
          );
        },
      ),
    );
  }
}
