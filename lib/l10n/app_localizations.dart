import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ArrowClash'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterAValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterAValidEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @passwordMustBeAtLeast6Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeast6Characters;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcome(Object name);

  /// No description provided for @selectAGameMode.
  ///
  /// In en, this message translates to:
  /// **'Select a Game Mode'**
  String get selectAGameMode;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @gameSelection.
  ///
  /// In en, this message translates to:
  /// **'Game Selection'**
  String get gameSelection;

  /// No description provided for @setupTournament.
  ///
  /// In en, this message translates to:
  /// **'Setup Tournament'**
  String get setupTournament;

  /// No description provided for @step1GameConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Game Configuration'**
  String get step1GameConfiguration;

  /// No description provided for @numberOfTeamsParticipants.
  ///
  /// In en, this message translates to:
  /// **'Number of Teams/Participants'**
  String get numberOfTeamsParticipants;

  /// No description provided for @pleaseEnterANumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get pleaseEnterANumber;

  /// No description provided for @pleaseEnterANumberBetween1And20.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number between 1 and 20'**
  String get pleaseEnterANumberBetween1And20;

  /// No description provided for @numberOfVolleys.
  ///
  /// In en, this message translates to:
  /// **'Number of Ends'**
  String get numberOfVolleys;

  /// No description provided for @pleaseEnterANumberBetween2And10.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number between 2 and 10'**
  String get pleaseEnterANumberBetween2And10;

  /// No description provided for @pleaseEnterAnEvenNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter an even number'**
  String get pleaseEnterAnEvenNumber;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @step2EnterNames.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Enter Names'**
  String get step2EnterNames;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @archer.
  ///
  /// In en, this message translates to:
  /// **'Archer'**
  String get archer;

  /// No description provided for @pleaseEnterAName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterAName;

  /// No description provided for @confirmNames.
  ///
  /// In en, this message translates to:
  /// **'Confirm Names'**
  String get confirmNames;

  /// No description provided for @volley.
  ///
  /// In en, this message translates to:
  /// **'End {number}'**
  String volley(Object number);

  /// No description provided for @gameInProgress.
  ///
  /// In en, this message translates to:
  /// **'Game in Progress'**
  String get gameInProgress;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current: {name}'**
  String current(Object name);

  /// No description provided for @currentTotal.
  ///
  /// In en, this message translates to:
  /// **'Current Total: {score}'**
  String currentTotal(Object score);

  /// No description provided for @oddVolleyDivisive.
  ///
  /// In en, this message translates to:
  /// **'Odd End - Divisive'**
  String get oddVolleyDivisive;

  /// No description provided for @evenVolleyMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Even End - Multiplier'**
  String get evenVolleyMultiplier;

  /// No description provided for @archerA3ArrowsArcherBTheBull.
  ///
  /// In en, this message translates to:
  /// **'Archer A 3 arrows - Archer B the Bull'**
  String get archerA3ArrowsArcherBTheBull;

  /// No description provided for @archerB3ArrowsArcherATheBull.
  ///
  /// In en, this message translates to:
  /// **'Archer B 3 arrows - Archer A the Bull'**
  String get archerB3ArrowsArcherATheBull;

  /// No description provided for @archerA3ArrowsArcherBTarget.
  ///
  /// In en, this message translates to:
  /// **'Archer A 3 arrows - Archer B target'**
  String get archerA3ArrowsArcherBTarget;

  /// No description provided for @archerB3ArrowsArcherATarget.
  ///
  /// In en, this message translates to:
  /// **'Archer B 3 arrows - Archer A target'**
  String get archerB3ArrowsArcherATarget;

  /// No description provided for @standardScoring.
  ///
  /// In en, this message translates to:
  /// **'Standard scoring'**
  String get standardScoring;

  /// No description provided for @selectScores.
  ///
  /// In en, this message translates to:
  /// **'Select Scores:'**
  String get selectScores;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @arrow.
  ///
  /// In en, this message translates to:
  /// **'Arrow {number}'**
  String arrow(Object number);

  /// No description provided for @special.
  ///
  /// In en, this message translates to:
  /// **'Special'**
  String get special;

  /// No description provided for @bull.
  ///
  /// In en, this message translates to:
  /// **'Bull'**
  String get bull;

  /// No description provided for @target.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get target;

  /// No description provided for @validateVolley.
  ///
  /// In en, this message translates to:
  /// **'Validate Volley'**
  String get validateVolley;

  /// No description provided for @pleaseSelectAllScores.
  ///
  /// In en, this message translates to:
  /// **'Please select all scores'**
  String get pleaseSelectAllScores;

  /// No description provided for @exitGame.
  ///
  /// In en, this message translates to:
  /// **'Exit Game'**
  String get exitGame;

  /// No description provided for @areYouSureYouWantToExit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the current game? All progress will be lost.'**
  String get areYouSureYouWantToExit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTitle;

  /// No description provided for @noGameHistoryAvailable.
  ///
  /// In en, this message translates to:
  /// **'No game history available'**
  String get noGameHistoryAvailable;

  /// No description provided for @playSomeGamesToSeeYourStatistics.
  ///
  /// In en, this message translates to:
  /// **'Play some games to see your statistics here'**
  String get playSomeGamesToSeeYourStatistics;

  /// No description provided for @playAGame.
  ///
  /// In en, this message translates to:
  /// **'Play a Game'**
  String get playAGame;

  /// No description provided for @totalGames.
  ///
  /// In en, this message translates to:
  /// **'Total Games'**
  String get totalGames;

  /// No description provided for @gameTypes.
  ///
  /// In en, this message translates to:
  /// **'Game Types'**
  String get gameTypes;

  /// No description provided for @mostPlayed.
  ///
  /// In en, this message translates to:
  /// **'Most Played'**
  String get mostPlayed;

  /// No description provided for @gameTypeDistribution.
  ///
  /// In en, this message translates to:
  /// **'Game Type Distribution'**
  String get gameTypeDistribution;

  /// No description provided for @recentGames.
  ///
  /// In en, this message translates to:
  /// **'Recent Games'**
  String get recentGames;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants:'**
  String get participants;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @noScoreDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No score data available'**
  String get noScoreDataAvailable;

  /// No description provided for @gameResults.
  ///
  /// In en, this message translates to:
  /// **'Game Results'**
  String get gameResults;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @saveResults.
  ///
  /// In en, this message translates to:
  /// **'Save Results'**
  String get saveResults;

  /// No description provided for @finalResults.
  ///
  /// In en, this message translates to:
  /// **'Final Results'**
  String get finalResults;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @scoreEvolution.
  ///
  /// In en, this message translates to:
  /// **'Score Evolution'**
  String get scoreEvolution;

  /// No description provided for @resultsSaved.
  ///
  /// In en, this message translates to:
  /// **'Results Saved'**
  String get resultsSaved;

  /// No description provided for @gameResultsHaveBeenSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Game results have been saved successfully.'**
  String get gameResultsHaveBeenSavedSuccessfully;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableOrDisableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable notifications'**
  String get enableOrDisableNotifications;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @enableDarkTheme.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme'**
  String get enableDarkTheme;

  /// No description provided for @gamesPlayed.
  ///
  /// In en, this message translates to:
  /// **'Games Played'**
  String get gamesPlayed;

  /// No description provided for @victories.
  ///
  /// In en, this message translates to:
  /// **'Victories'**
  String get victories;

  /// No description provided for @maxScore.
  ///
  /// In en, this message translates to:
  /// **'Max Score'**
  String get maxScore;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @areYouSureYouWantToLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get areYouSureYouWantToLogout;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred. Please try again.'**
  String get networkError;

  /// No description provided for @authenticationError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please check your credentials.'**
  String get authenticationError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get unknownError;

  /// No description provided for @noDataError.
  ///
  /// In en, this message translates to:
  /// **'No data available.'**
  String get noDataError;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccess;

  /// No description provided for @gameSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Game results saved successfully!'**
  String get gameSavedSuccess;

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have been logged out successfully!'**
  String get logoutSuccess;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterEmailToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to reset your password'**
  String get enterEmailToResetPassword;

  /// No description provided for @sendResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Email'**
  String get sendResetEmail;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Reset email sent!'**
  String get resetEmailSent;

  /// No description provided for @checkEmailForResetInstructions.
  ///
  /// In en, this message translates to:
  /// **'Check your email for password reset instructions'**
  String get checkEmailForResetInstructions;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @gameTypeDuo.
  ///
  /// In en, this message translates to:
  /// **'Mixed team: beginner + veteran'**
  String get gameTypeDuo;

  /// No description provided for @gameTypeClassica.
  ///
  /// In en, this message translates to:
  /// **'Classic archery game'**
  String get gameTypeClassica;

  /// No description provided for @gameTypeBull.
  ///
  /// In en, this message translates to:
  /// **'Bull\'s eye challenge'**
  String get gameTypeBull;

  /// No description provided for @gameTypeImpact.
  ///
  /// In en, this message translates to:
  /// **'Target impact game'**
  String get gameTypeImpact;

  /// No description provided for @gameTypeSolo.
  ///
  /// In en, this message translates to:
  /// **'Individual 18m game'**
  String get gameTypeSolo;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed. Please try again.'**
  String get logoutFailed;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get invalidCredentials;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email.'**
  String get userNotFound;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists.'**
  String get emailAlreadyExists;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Please choose a stronger password.'**
  String get weakPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again later.'**
  String get tooManyRequests;

  /// No description provided for @emailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your email address before logging in.'**
  String get emailNotConfirmed;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired. Please log in again.'**
  String get sessionExpired;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
