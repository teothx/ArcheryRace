// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Archery Race';

  @override
  String get login => 'Accedi';

  @override
  String get register => 'Registrati';

  @override
  String get name => 'Nome';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get pleaseEnterYourName => 'Inserisci il tuo nome';

  @override
  String get pleaseEnterYourEmail => 'Inserisci la tua email';

  @override
  String get pleaseEnterAValidEmail => 'Inserisci un\'email valida';

  @override
  String get pleaseEnterYourPassword => 'Inserisci la tua password';

  @override
  String get passwordMustBeAtLeast6Characters => 'La password deve essere di almeno 6 caratteri';

  @override
  String welcome(Object name) {
    return 'Benvenuto, $name!';
  }

  @override
  String get selectAGameMode => 'Seleziona una Modalità di Gioco';

  @override
  String get profile => 'Profilo';

  @override
  String get statistics => 'Statistiche';

  @override
  String get logout => 'Logout';

  @override
  String get gameSelection => 'Selezione Gioco';

  @override
  String get setupTournament => 'Impostazione Torneo';

  @override
  String get step1GameConfiguration => 'Passo 1: Configurazione Gioco';

  @override
  String get numberOfTeamsParticipants => 'Numero di Squadre/Partecipanti';

  @override
  String get pleaseEnterANumber => 'Inserisci un numero';

  @override
  String get pleaseEnterANumberBetween1And20 => 'Inserisci un numero tra 1 e 20';

  @override
  String get numberOfVolleys => 'Numero di Volée';

  @override
  String get pleaseEnterANumberBetween2And10 => 'Inserisci un numero tra 2 e 10';

  @override
  String get pleaseEnterAnEvenNumber => 'Inserisci un numero pari';

  @override
  String get confirm => 'Conferma';

  @override
  String get step2EnterNames => 'Passo 2: Inserisci Nomi';

  @override
  String get team => 'Squadra';

  @override
  String get archer => 'Arciere';

  @override
  String get pleaseEnterAName => 'Inserisci un nome';

  @override
  String get confirmNames => 'Conferma Nomi';

  @override
  String volley(Object number) {
    return 'Volée $number';
  }

  @override
  String get gameInProgress => 'Gioco in Corso';

  @override
  String current(Object name) {
    return 'Attuale: $name';
  }

  @override
  String currentTotal(Object score) {
    return 'Punteggio Attuale: $score';
  }

  @override
  String get oddVolleyDivisive => 'Volée Dispari - Divisivo';

  @override
  String get evenVolleyMultiplier => 'Volée Pari - Moltiplicatore';

  @override
  String get archerA3ArrowsArcherBTheBull => 'Arciere A 3 frecce - Arciere B il Centro';

  @override
  String get archerB3ArrowsArcherATheBull => 'Arciere B 3 frecce - Arciere A il Centro';

  @override
  String get archerA3ArrowsArcherBTarget => 'Arciere A 3 frecce - Arciere B bersaglio';

  @override
  String get archerB3ArrowsArcherATarget => 'Arciere B 3 frecce - Arciere A bersaglio';

  @override
  String get standardScoring => 'Punteggio standard';

  @override
  String get selectScores => 'Seleziona Punteggi:';

  @override
  String get score => 'Punteggio';

  @override
  String arrow(Object number) {
    return 'Freccia $number';
  }

  @override
  String get special => 'Speciale';

  @override
  String get bull => 'Centro';

  @override
  String get target => 'Bersaglio';

  @override
  String get validateVolley => 'Valida Volée';

  @override
  String get pleaseSelectAllScores => 'Seleziona tutti i punteggi';

  @override
  String get exitGame => 'Esci dal Gioco';

  @override
  String get areYouSureYouWantToExit => 'Sei sicuro di voler uscire dal gioco corrente? Tutti i progressi andranno persi.';

  @override
  String get cancel => 'Annulla';

  @override
  String get exit => 'Esci';

  @override
  String get rules => 'Regole';

  @override
  String get back => 'Indietro';

  @override
  String get startGame => 'Inizia Gioco';

  @override
  String get statisticsTitle => 'Statistiche';

  @override
  String get noGameHistoryAvailable => 'Nessuna cronologia di giochi disponibile';

  @override
  String get playSomeGamesToSeeYourStatistics => 'Gioca qualche partita per vedere le tue statistiche qui';

  @override
  String get playAGame => 'Gioca una Partita';

  @override
  String get totalGames => 'Partite Totali';

  @override
  String get gameTypes => 'Tipi di Gioco';

  @override
  String get mostPlayed => 'Più Giocato';

  @override
  String get gameTypeDistribution => 'Distribuzione Tipi di Gioco';

  @override
  String get recentGames => 'Partite Recenti';

  @override
  String get participants => 'Partecipanti:';

  @override
  String get close => 'Chiudi';

  @override
  String get noScoreDataAvailable => 'Nessun dato di punteggio disponibile';

  @override
  String get gameResults => 'Risultati Gioco';

  @override
  String get backToHome => 'Torna alla Home';

  @override
  String get saveResults => 'Salva Risultati';

  @override
  String get finalResults => 'Risultati Finali';

  @override
  String get rank => 'Posizione';

  @override
  String get total => 'Totale';

  @override
  String get scoreEvolution => 'Evoluzione Punteggio';

  @override
  String get resultsSaved => 'Risultati Salvati';

  @override
  String get gameResultsHaveBeenSavedSuccessfully => 'I risultati del gioco sono stati salvati con successo.';

  @override
  String get ok => 'OK';

  @override
  String get userProfile => 'Profilo Utente';

  @override
  String get personalInformation => 'Informazioni Personali';

  @override
  String get appSettings => 'Impostazioni App';

  @override
  String get notifications => 'Notifiche';

  @override
  String get enableOrDisableNotifications => 'Abilita o disabilita le notifiche';

  @override
  String get darkTheme => 'Tema Scuro';

  @override
  String get enableDarkTheme => 'Abilita il tema scuro';

  @override
  String get gamesPlayed => 'Partite Giocate';

  @override
  String get victories => 'Vittorie';

  @override
  String get maxScore => 'Punteggio Max';

  @override
  String get confirmLogout => 'Conferma Logout';

  @override
  String get areYouSureYouWantToLogout => 'Sei sicuro di voler effettuare il logout?';

  @override
  String get loading => 'Caricamento...';

  @override
  String get networkError => 'Errore di rete. Riprova più tardi.';

  @override
  String get authenticationError => 'Autenticazione fallita. Controlla le tue credenziali.';

  @override
  String get unknownError => 'Si è verificato un errore sconosciuto. Riprova.';

  @override
  String get noDataError => 'Nessun dato disponibile.';

  @override
  String get loginSuccess => 'Login effettuato con successo!';

  @override
  String get registrationSuccess => 'Registrazione completata con successo!';

  @override
  String get gameSavedSuccess => 'Risultati del gioco salvati con successo!';

  @override
  String get logoutSuccess => 'Sei stato disconnesso con successo!';

  @override
  String get gameTypeDuo => 'Squadra mista: principiante + veterano';

  @override
  String get gameTypeClassica => 'Gioco classico di tiro con l\'arco';

  @override
  String get gameTypeBull => 'Sfida al centro del bersaglio';

  @override
  String get gameTypeImpact => 'Gioco di impatto sul bersaglio';

  @override
  String get gameTypeSolo => 'Gioco individuale 18m';
}
