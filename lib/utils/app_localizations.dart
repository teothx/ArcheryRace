import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final Locale locale;

  AppLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'ArrowClash',
      'login': 'Login',
      'register': 'Register',
      'name': 'Name',
      'email': 'Email',
      'password': 'Password',
      'pleaseEnterYourName': 'Please enter your name',
      'pleaseEnterYourEmail': 'Please enter your email',
      'pleaseEnterAValidEmail': 'Please enter a valid email',
      'pleaseEnterYourPassword': 'Please enter your password',
      'passwordMustBeAtLeast6Characters': 'Password must be at least 6 characters',
      'welcome': 'Welcome, {name}!',
      'selectAGameMode': 'Select a Game Mode',
      'profile': 'Profile',
      'statistics': 'Statistics',
      'logout': 'Logout',
      'gameSelection': 'Game Selection',
      'setupTournament': 'Setup Tournament',
      'step1GameConfiguration': 'Step 1: Game Configuration',
      'numberOfTeamsParticipants': 'Number of Teams/Participants',
      'pleaseEnterANumber': 'Please enter a number',
      'pleaseEnterANumberBetween1And20': 'Please enter a number between 1 and 20',
      'numberOfVolleys': 'Number of Volleys',
      'pleaseEnterANumberBetween2And10': 'Please enter a number between 2 and 10',
      'pleaseEnterAnEvenNumber': 'Please enter an even number',
      'confirm': 'Confirm',
      'step2EnterNames': 'Step 2: Enter Names',
      'team': 'Team',
      'archer': 'Archer',
      'pleaseEnterAName': 'Please enter a name',
      'confirmNames': 'Confirm Names',
      'volley': 'Volley {number}',
      'gameInProgress': 'Game in Progress',
      'current': 'Current: {name}',
      'currentTotal': 'Current Total: {score}',
      'oddVolleyDivisive': 'Odd Volley - Divisive',
      'evenVolleyMultiplier': 'Even Volley - Multiplier',
      'archerA3ArrowsArcherBTheBull': 'Archer A 3 arrows - Archer B the Bull',
      'archerB3ArrowsArcherATheBull': 'Archer B 3 arrows - Archer A the Bull',
      'archerA3ArrowsArcherBTarget': 'Archer A 3 arrows - Archer B target',
      'archerB3ArrowsArcherATarget': 'Archer B 3 arrows - Archer A target',
      'standardScoring': 'Standard scoring',
      'selectScores': 'Select Scores:',
      'score': 'Score',
      'arrow': 'Arrow {number}',
      'special': 'Special',
      'bull': 'Bull',
      'target': 'Target',
      'validateVolley': 'Validate Volley',
      'pleaseSelectAllScores': 'Please select all scores',
      'exitGame': 'Exit Game',
      'areYouSureYouWantToExit': 'Are you sure you want to exit the current game? All progress will be lost.',
      'cancel': 'Cancel',
      'exit': 'Exit',
      'rules': 'Rules',
      'back': 'Back',
      'startGame': 'Start Game',
      'statisticsTitle': 'Statistics',
      'noGameHistoryAvailable': 'No game history available',
      'playSomeGamesToSeeYourStatistics': 'Play some games to see your statistics here',
      'playAGame': 'Play a Game',
      'totalGames': 'Total Games',
      'gameTypes': 'Game Types',
      'mostPlayed': 'Most Played',
      'gameTypeDistribution': 'Game Type Distribution',
      'recentGames': 'Recent Games',
      'participants': 'Participants:',
      'close': 'Close',
      'noScoreDataAvailable': 'No score data available',
      'gameResults': 'Game Results',
      'backToHome': 'Back to Home',
      'saveResults': 'Save Results',
      'finalResults': 'Final Results',
      'rank': 'Rank',
      'name': 'Name',
      'total': 'Total',
      'scoreEvolution': 'Score Evolution',
      'resultsSaved': 'Results Saved',
      'gameResultsHaveBeenSavedSuccessfully': 'Game results have been saved successfully.',
      'ok': 'OK',
      'userProfile': 'User Profile',
      'personalInformation': 'Personal Information',
      'appSettings': 'App Settings',
      'notifications': 'Notifications',
      'enableOrDisableNotifications': 'Enable or disable notifications',
      'darkTheme': 'Dark Theme',
      'enableDarkTheme': 'Enable dark theme',
      'statistics': 'Statistics',
      'gamesPlayed': 'Games Played',
      'victories': 'Victories',
      'maxScore': 'Max Score',
      'confirmLogout': 'Confirm Logout',
      'areYouSureYouWantToLogout': 'Are you sure you want to logout?',
      'loading': 'Loading...',
      'networkError': 'Network error occurred. Please try again.',
      'authenticationError': 'Authentication failed. Please check your credentials.',
      'unknownError': 'An unknown error occurred. Please try again.',
      'noDataError': 'No data available.',
      'loginSuccess': 'Login successful!',
      'registrationSuccess': 'Registration successful!',
      'gameSavedSuccess': 'Game results saved successfully!',
      'logoutSuccess': 'You have been logged out successfully!',
      'gameTypeDuo': 'Mixed team: beginner + veteran',
      'gameTypeClassica': 'Classic archery game',
      'gameTypeBull': 'Bull\'s eye challenge',
      'gameTypeImpact': 'Target impact game',
      'gameTypeSolo': 'Individual 18m game',
    },
    'it': {
      'appName': 'ArrowClash',
      'login': 'Accedi',
      'register': 'Registrati',
      'name': 'Nome',
      'email': 'Email',
      'password': 'Password',
      'pleaseEnterYourName': 'Inserisci il tuo nome',
      'pleaseEnterYourEmail': 'Inserisci la tua email',
      'pleaseEnterAValidEmail': 'Inserisci un\'email valida',
      'pleaseEnterYourPassword': 'Inserisci la tua password',
      'passwordMustBeAtLeast6Characters': 'La password deve essere di almeno 6 caratteri',
      'welcome': 'Benvenuto, {name}!',
      'selectAGameMode': 'Seleziona una Modalità di Gioco',
      'profile': 'Profilo',
      'statistics': 'Statistiche',
      'logout': 'Logout',
      'gameSelection': 'Selezione Gioco',
      'setupTournament': 'Impostazione Torneo',
      'step1GameConfiguration': 'Passo 1: Configurazione Gioco',
      'numberOfTeamsParticipants': 'Numero di Squadre/Partecipanti',
      'pleaseEnterANumber': 'Inserisci un numero',
      'pleaseEnterANumberBetween1And20': 'Inserisci un numero tra 1 e 20',
      'numberOfVolleys': 'Numero di Volée',
      'pleaseEnterANumberBetween2And10': 'Inserisci un numero tra 2 e 10',
      'pleaseEnterAnEvenNumber': 'Inserisci un numero pari',
      'confirm': 'Conferma',
      'step2EnterNames': 'Passo 2: Inserisci Nomi',
      'team': 'Squadra',
      'archer': 'Arciere',
      'pleaseEnterAName': 'Inserisci un nome',
      'confirmNames': 'Conferma Nomi',
      'volley': 'Volée {number}',
      'gameInProgress': 'Gioco in Corso',
      'current': 'Attuale: {name}',
      'currentTotal': 'Punteggio Attuale: {score}',
      'oddVolleyDivisive': 'Volée Dispari - Divisivo',
      'evenVolleyMultiplier': 'Volée Pari - Moltiplicatore',
      'archerA3ArrowsArcherBTheBull': 'Arciere A 3 frecce - Arciere B il Centro',
      'archerB3ArrowsArcherATheBull': 'Arciere B 3 frecce - Arciere A il Centro',
      'archerA3ArrowsArcherBTarget': 'Arciere A 3 frecce - Arciere B bersaglio',
      'archerB3ArrowsArcherATarget': 'Arciere B 3 frecce - Arciere A bersaglio',
      'standardScoring': 'Punteggio standard',
      'selectScores': 'Seleziona Punteggi:',
      'score': 'Punteggio',
      'arrow': 'Freccia {number}',
      'special': 'Speciale',
      'bull': 'Centro',
      'target': 'Bersaglio',
      'validateVolley': 'Valida Volée',
      'pleaseSelectAllScores': 'Seleziona tutti i punteggi',
      'exitGame': 'Esci dal Gioco',
      'areYouSureYouWantToExit': 'Sei sicuro di voler uscire dal gioco corrente? Tutti i progressi andranno persi.',
      'cancel': 'Annulla',
      'exit': 'Esci',
      'rules': 'Regole',
      'back': 'Indietro',
      'startGame': 'Inizia Gioco',
      'statisticsTitle': 'Statistiche',
      'noGameHistoryAvailable': 'Nessuna cronologia di giochi disponibile',
      'playSomeGamesToSeeYourStatistics': 'Gioca qualche partita per vedere le tue statistiche qui',
      'playAGame': 'Gioca una Partita',
      'totalGames': 'Partite Totali',
      'gameTypes': 'Tipi di Gioco',
      'mostPlayed': 'Più Giocato',
      'gameTypeDistribution': 'Distribuzione Tipi di Gioco',
      'recentGames': 'Partite Recenti',
      'participants': 'Partecipanti:',
      'close': 'Chiudi',
      'noScoreDataAvailable': 'Nessun dato di punteggio disponibile',
      'gameResults': 'Risultati Gioco',
      'backToHome': 'Torna alla Home',
      'saveResults': 'Salva Risultati',
      'finalResults': 'Risultati Finali',
      'rank': 'Posizione',
      'name': 'Nome',
      'total': 'Totale',
      'scoreEvolution': 'Evoluzione Punteggio',
      'resultsSaved': 'Risultati Salvati',
      'gameResultsHaveBeenSavedSuccessfully': 'I risultati del gioco sono stati salvati con successo.',
      'ok': 'OK',
      'userProfile': 'Profilo Utente',
      'personalInformation': 'Informazioni Personali',
      'appSettings': 'Impostazioni App',
      'notifications': 'Notifiche',
      'enableOrDisableNotifications': 'Abilita o disabilita le notifiche',
      'darkTheme': 'Tema Scuro',
      'enableDarkTheme': 'Abilita il tema scuro',
      'statistics': 'Statistiche',
      'gamesPlayed': 'Partite Giocate',
      'victories': 'Vittorie',
      'maxScore': 'Punteggio Max',
      'confirmLogout': 'Conferma Logout',
      'areYouSureYouWantToLogout': 'Sei sicuro di voler effettuare il logout?',
      'loading': 'Caricamento...',
      'networkError': 'Errore di rete. Riprova più tardi.',
      'authenticationError': 'Autenticazione fallita. Controlla le tue credenziali.',
      'unknownError': 'Si è verificato un errore sconosciuto. Riprova.',
      'noDataError': 'Nessun dato disponibile.',
      'loginSuccess': 'Login effettuato con successo!',
      'registrationSuccess': 'Registrazione completata con successo!',
      'gameSavedSuccess': 'Risultati del gioco salvati con successo!',
      'logoutSuccess': 'Sei stato disconnesso con successo!',
      'gameTypeDuo': 'Squadra mista: principiante + veterano',
      'gameTypeClassica': 'Gioco classico di tiro con l\'arco',
      'gameTypeBull': 'Sfida al centro del bersaglio',
      'gameTypeImpact': 'Gioco di impatto sul bersaglio',
      'gameTypeSolo': 'Gioco individuale 18m',
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get pleaseEnterYourName => _localizedValues[locale.languageCode]!['pleaseEnterYourName']!;
  String get pleaseEnterYourEmail => _localizedValues[locale.languageCode]!['pleaseEnterYourEmail']!;
  String get pleaseEnterAValidEmail => _localizedValues[locale.languageCode]!['pleaseEnterAValidEmail']!;
  String get pleaseEnterYourPassword => _localizedValues[locale.languageCode]!['pleaseEnterYourPassword']!;
  String get passwordMustBeAtLeast6Characters => _localizedValues[locale.languageCode]!['passwordMustBeAtLeast6Characters']!;
  String welcome(String name) => _localizedValues[locale.languageCode]!['welcome']!.replaceAll('{name}', name);
  String get selectAGameMode => _localizedValues[locale.languageCode]!['selectAGameMode']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;
  String get statistics => _localizedValues[locale.languageCode]!['statistics']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get gameSelection => _localizedValues[locale.languageCode]!['gameSelection']!;
  String get setupTournament => _localizedValues[locale.languageCode]!['setupTournament']!;
  String get step1GameConfiguration => _localizedValues[locale.languageCode]!['step1GameConfiguration']!;
  String get numberOfTeamsParticipants => _localizedValues[locale.languageCode]!['numberOfTeamsParticipants']!;
  String get pleaseEnterANumber => _localizedValues[locale.languageCode]!['pleaseEnterANumber']!;
  String get pleaseEnterANumberBetween1And20 => _localizedValues[locale.languageCode]!['pleaseEnterANumberBetween1And20']!;
  String get numberOfVolleys => _localizedValues[locale.languageCode]!['numberOfVolleys']!;
  String get pleaseEnterANumberBetween2And10 => _localizedValues[locale.languageCode]!['pleaseEnterANumberBetween2And10']!;
  String get pleaseEnterAnEvenNumber => _localizedValues[locale.languageCode]!['pleaseEnterAnEvenNumber']!;
  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;
  String get step2EnterNames => _localizedValues[locale.languageCode]!['step2EnterNames']!;
  String get team => _localizedValues[locale.languageCode]!['team']!;
  String get archer => _localizedValues[locale.languageCode]!['archer']!;
  String get pleaseEnterAName => _localizedValues[locale.languageCode]!['pleaseEnterAName']!;
  String get confirmNames => _localizedValues[locale.languageCode]!['confirmNames']!;
  String volley(int number) => _localizedValues[locale.languageCode]!['volley']!.replaceAll('{number}', number.toString());
  String get gameInProgress => _localizedValues[locale.languageCode]!['gameInProgress']!;
  String current(String name) => _localizedValues[locale.languageCode]!['current']!.replaceAll('{name}', name);
  String currentTotal(String score) => _localizedValues[locale.languageCode]!['currentTotal']!.replaceAll('{score}', score);
  String get oddVolleyDivisive => _localizedValues[locale.languageCode]!['oddVolleyDivisive']!;
  String get evenVolleyMultiplier => _localizedValues[locale.languageCode]!['evenVolleyMultiplier']!;
  String get archerA3ArrowsArcherBTheBull => _localizedValues[locale.languageCode]!['archerA3ArrowsArcherBTheBull']!;
  String get archerB3ArrowsArcherATheBull => _localizedValues[locale.languageCode]!['archerB3ArrowsArcherATheBull']!;
  String get archerA3ArrowsArcherBTarget => _localizedValues[locale.languageCode]!['archerA3ArrowsArcherBTarget']!;
  String get archerB3ArrowsArcherATarget => _localizedValues[locale.languageCode]!['archerB3ArrowsArcherATarget']!;
  String get standardScoring => _localizedValues[locale.languageCode]!['standardScoring']!;
  String get selectScores => _localizedValues[locale.languageCode]!['selectScores']!;
  String get score => _localizedValues[locale.languageCode]!['score']!;
  String arrow(int number) => _localizedValues[locale.languageCode]!['arrow']!.replaceAll('{number}', number.toString());
  String get special => _localizedValues[locale.languageCode]!['special']!;
  String get bull => _localizedValues[locale.languageCode]!['bull']!;
  String get target => _localizedValues[locale.languageCode]!['target']!;
  String get validateVolley => _localizedValues[locale.languageCode]!['validateVolley']!;
  String get pleaseSelectAllScores => _localizedValues[locale.languageCode]!['pleaseSelectAllScores']!;
  String get exitGame => _localizedValues[locale.languageCode]!['exitGame']!;
  String get areYouSureYouWantToExit => _localizedValues[locale.languageCode]!['areYouSureYouWantToExit']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get exit => _localizedValues[locale.languageCode]!['exit']!;
  String get rules => _localizedValues[locale.languageCode]!['rules']!;
  String get back => _localizedValues[locale.languageCode]!['back']!;
  String get startGame => _localizedValues[locale.languageCode]!['startGame']!;
  String get statisticsTitle => _localizedValues[locale.languageCode]!['statisticsTitle']!;
  String get noGameHistoryAvailable => _localizedValues[locale.languageCode]!['noGameHistoryAvailable']!;
  String get playSomeGamesToSeeYourStatistics => _localizedValues[locale.languageCode]!['playSomeGamesToSeeYourStatistics']!;
  String get playAGame => _localizedValues[locale.languageCode]!['playAGame']!;
  String get totalGames => _localizedValues[locale.languageCode]!['totalGames']!;
  String get gameTypes => _localizedValues[locale.languageCode]!['gameTypes']!;
  String get mostPlayed => _localizedValues[locale.languageCode]!['mostPlayed']!;
  String get gameTypeDistribution => _localizedValues[locale.languageCode]!['gameTypeDistribution']!;
  String get recentGames => _localizedValues[locale.languageCode]!['recentGames']!;
  String get participants => _localizedValues[locale.languageCode]!['participants']!;
  String get close => _localizedValues[locale.languageCode]!['close']!;
  String get noScoreDataAvailable => _localizedValues[locale.languageCode]!['noScoreDataAvailable']!;
  String get gameResults => _localizedValues[locale.languageCode]!['gameResults']!;
  String get backToHome => _localizedValues[locale.languageCode]!['backToHome']!;
  String get saveResults => _localizedValues[locale.languageCode]!['saveResults']!;
  String get finalResults => _localizedValues[locale.languageCode]!['finalResults']!;
  String get rank => _localizedValues[locale.languageCode]!['rank']!;
  String get nameColumn => _localizedValues[locale.languageCode]!['name']!;
  String get total => _localizedValues[locale.languageCode]!['total']!;
  String get scoreEvolution => _localizedValues[locale.languageCode]!['scoreEvolution']!;
  String get resultsSaved => _localizedValues[locale.languageCode]!['resultsSaved']!;
  String get gameResultsHaveBeenSavedSuccessfully => _localizedValues[locale.languageCode]!['gameResultsHaveBeenSavedSuccessfully']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get userProfile => _localizedValues[locale.languageCode]!['userProfile']!;
  String get personalInformation => _localizedValues[locale.languageCode]!['personalInformation']!;
  String get appSettings => _localizedValues[locale.languageCode]!['appSettings']!;
  String get notifications => _localizedValues[locale.languageCode]!['notifications']!;
  String get enableOrDisableNotifications => _localizedValues[locale.languageCode]!['enableOrDisableNotifications']!;
  String get darkTheme => _localizedValues[locale.languageCode]!['darkTheme']!;
  String get enableDarkTheme => _localizedValues[locale.languageCode]!['enableDarkTheme']!;
  String get statisticsPage => _localizedValues[locale.languageCode]!['statistics']!;
  String get gamesPlayed => _localizedValues[locale.languageCode]!['gamesPlayed']!;
  String get victories => _localizedValues[locale.languageCode]!['victories']!;
  String get maxScore => _localizedValues[locale.languageCode]!['maxScore']!;
  String get confirmLogout => _localizedValues[locale.languageCode]!['confirmLogout']!;
  String get areYouSureYouWantToLogout => _localizedValues[locale.languageCode]!['areYouSureYouWantToLogout']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get networkError => _localizedValues[locale.languageCode]!['networkError']!;
  String get authenticationError => _localizedValues[locale.languageCode]!['authenticationError']!;
  String get unknownError => _localizedValues[locale.languageCode]!['unknownError']!;
  String get noDataError => _localizedValues[locale.languageCode]!['noDataError']!;
  String get loginSuccess => _localizedValues[locale.languageCode]!['loginSuccess']!;
  String get registrationSuccess => _localizedValues[locale.languageCode]!['registrationSuccess']!;
  String get gameSavedSuccess => _localizedValues[locale.languageCode]!['gameSavedSuccess']!;
  String get logoutSuccess => _localizedValues[locale.languageCode]!['logoutSuccess']!;
  String get gameTypeDuo => _localizedValues[locale.languageCode]!['gameTypeDuo']!;
  String get gameTypeClassica => _localizedValues[locale.languageCode]!['gameTypeClassica']!;
  String get gameTypeBull => _localizedValues[locale.languageCode]!['gameTypeBull']!;
  String get gameTypeImpact => _localizedValues[locale.languageCode]!['gameTypeImpact']!;
  String get gameTypeSolo => _localizedValues[locale.languageCode]!['gameTypeSolo']!;

  static Future<void> setLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
  }

  static Future<String> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language_code') ?? 'en';
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}