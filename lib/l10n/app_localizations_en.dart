// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ArrowClash';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get pleaseEnterAValidEmail => 'Please enter a valid email';

  @override
  String get pleaseEnterYourPassword => 'Please enter your password';

  @override
  String get passwordMustBeAtLeast6Characters => 'Password must be at least 6 characters';

  @override
  String welcome(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get selectAGameMode => 'Select a Game Mode';

  @override
  String get profile => 'Profile';

  @override
  String get statistics => 'Statistics';

  @override
  String get logout => 'Logout';

  @override
  String get gameSelection => 'Game Selection';

  @override
  String get setupTournament => 'Setup Tournament';

  @override
  String get step1GameConfiguration => 'Step 1: Game Configuration';

  @override
  String get numberOfTeamsParticipants => 'Number of Teams/Participants';

  @override
  String get pleaseEnterANumber => 'Please enter a number';

  @override
  String get pleaseEnterANumberBetween1And20 => 'Please enter a number between 1 and 20';

  @override
  String get numberOfVolleys => 'Number of Ends';

  @override
  String get pleaseEnterANumberBetween2And10 => 'Please enter a number between 2 and 10';

  @override
  String get pleaseEnterAnEvenNumber => 'Please enter an even number';

  @override
  String get confirm => 'Confirm';

  @override
  String get step2EnterNames => 'Step 2: Enter Names';

  @override
  String get team => 'Team';

  @override
  String get archer => 'Archer';

  @override
  String get pleaseEnterAName => 'Please enter a name';

  @override
  String get confirmNames => 'Confirm Names';

  @override
  String volley(Object number) {
    return 'End $number';
  }

  @override
  String get gameInProgress => 'Game in Progress';

  @override
  String current(Object name) {
    return 'Current: $name';
  }

  @override
  String currentTotal(Object score) {
    return 'Current Total: $score';
  }

  @override
  String get oddVolleyDivisive => 'Odd End - Divisive';

  @override
  String get evenVolleyMultiplier => 'Even End - Multiplier';

  @override
  String get archerA3ArrowsArcherBTheBull => 'Archer A 3 arrows - Archer B the Bull';

  @override
  String get archerB3ArrowsArcherATheBull => 'Archer B 3 arrows - Archer A the Bull';

  @override
  String get archerA3ArrowsArcherBTarget => 'Archer A 3 arrows - Archer B target';

  @override
  String get archerB3ArrowsArcherATarget => 'Archer B 3 arrows - Archer A target';

  @override
  String get standardScoring => 'Standard scoring';

  @override
  String get selectScores => 'Select Scores:';

  @override
  String get score => 'Score';

  @override
  String arrow(Object number) {
    return 'Arrow $number';
  }

  @override
  String get special => 'Special';

  @override
  String get bull => 'Bull';

  @override
  String get target => 'Target';

  @override
  String get validateVolley => 'Validate Volley';

  @override
  String get pleaseSelectAllScores => 'Please select all scores';

  @override
  String get exitGame => 'Exit Game';

  @override
  String get areYouSureYouWantToExit => 'Are you sure you want to exit the current game? All progress will be lost.';

  @override
  String get cancel => 'Cancel';

  @override
  String get exit => 'Exit';

  @override
  String get rules => 'Rules';

  @override
  String get back => 'Back';

  @override
  String get startGame => 'Start Game';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get noGameHistoryAvailable => 'No game history available';

  @override
  String get playSomeGamesToSeeYourStatistics => 'Play some games to see your statistics here';

  @override
  String get playAGame => 'Play a Game';

  @override
  String get totalGames => 'Total Games';

  @override
  String get gameTypes => 'Game Types';

  @override
  String get mostPlayed => 'Most Played';

  @override
  String get gameTypeDistribution => 'Game Type Distribution';

  @override
  String get recentGames => 'Recent Games';

  @override
  String get participants => 'Participants:';

  @override
  String get close => 'Close';

  @override
  String get noScoreDataAvailable => 'No score data available';

  @override
  String get gameResults => 'Game Results';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get saveResults => 'Save Results';

  @override
  String get finalResults => 'Final Results';

  @override
  String get rank => 'Rank';

  @override
  String get total => 'Total';

  @override
  String get scoreEvolution => 'Score Evolution';

  @override
  String get resultsSaved => 'Results Saved';

  @override
  String get gameResultsHaveBeenSavedSuccessfully => 'Game results have been saved successfully.';

  @override
  String get ok => 'OK';

  @override
  String get userProfile => 'User Profile';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get appSettings => 'App Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableOrDisableNotifications => 'Enable or disable notifications';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get enableDarkTheme => 'Enable dark theme';

  @override
  String get gamesPlayed => 'Games Played';

  @override
  String get victories => 'Victories';

  @override
  String get maxScore => 'Max Score';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get areYouSureYouWantToLogout => 'Are you sure you want to logout?';

  @override
  String get loading => 'Loading...';

  @override
  String get networkError => 'Network error occurred. Please try again.';

  @override
  String get authenticationError => 'Authentication failed. Please check your credentials.';

  @override
  String get unknownError => 'An unknown error occurred. Please try again.';

  @override
  String get noDataError => 'No data available.';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get registrationSuccess => 'Registration successful!';

  @override
  String get gameSavedSuccess => 'Game results saved successfully!';

  @override
  String get logoutSuccess => 'You have been logged out successfully!';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterEmailToResetPassword => 'Enter your email address to reset your password';

  @override
  String get sendResetEmail => 'Send Reset Email';

  @override
  String get resetEmailSent => 'Reset email sent!';

  @override
  String get checkEmailForResetInstructions => 'Check your email for password reset instructions';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get gameTypeDuo => 'Mixed team: beginner + veteran';

  @override
  String get gameTypeClassica => 'Classic archery game';

  @override
  String get gameTypeBull => 'Bull\'s eye challenge';

  @override
  String get gameTypeImpact => 'Target impact game';

  @override
  String get gameTypeSolo => 'Individual 18m game';

  @override
  String get loginFailed => 'Login failed. Please check your credentials.';

  @override
  String get registrationFailed => 'Registration failed. Please try again.';

  @override
  String get logoutFailed => 'Logout failed. Please try again.';

  @override
  String get invalidCredentials => 'Invalid email or password.';

  @override
  String get userNotFound => 'User not found. Please check your email.';

  @override
  String get emailAlreadyExists => 'An account with this email already exists.';

  @override
  String get weakPassword => 'Password is too weak. Please choose a stronger password.';

  @override
  String get invalidEmail => 'Please enter a valid email address.';

  @override
  String get tooManyRequests => 'Too many login attempts. Please try again later.';

  @override
  String get emailNotConfirmed => 'Please confirm your email address before logging in.';

  @override
  String get sessionExpired => 'Your session has expired. Please log in again.';
}
