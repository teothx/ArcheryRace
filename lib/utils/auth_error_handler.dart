import '../l10n/app_localizations.dart';

class AuthErrorHandler {
  static String getLocalizedErrorMessage(String error, AppLocalizations localizations) {
    // Converti l'errore in lowercase per il matching
    final errorLower = error.toLowerCase();
    
    // Gestione errori specifici di Supabase
    if (errorLower.contains('invalid_credentials') || 
        errorLower.contains('invalid login credentials')) {
      return localizations.invalidCredentials;
    }
    
    if (errorLower.contains('user_not_found') || 
        errorLower.contains('user not found')) {
      return localizations.userNotFound;
    }
    
    if (errorLower.contains('email_already_exists') || 
        errorLower.contains('user_already_registered') ||
        errorLower.contains('email already registered')) {
      return localizations.emailAlreadyExists;
    }
    
    if (errorLower.contains('weak_password') || 
        errorLower.contains('password should be at least')) {
      return localizations.weakPassword;
    }
    
    if (errorLower.contains('invalid_email') || 
        errorLower.contains('invalid email')) {
      return localizations.invalidEmail;
    }
    
    if (errorLower.contains('too_many_requests') || 
        errorLower.contains('rate limit')) {
      return localizations.tooManyRequests;
    }
    
    if (errorLower.contains('email_not_confirmed') || 
        errorLower.contains('email not confirmed')) {
      return localizations.emailNotConfirmed;
    }
    
    if (errorLower.contains('session_expired') || 
        errorLower.contains('jwt expired')) {
      return localizations.sessionExpired;
    }
    
    if (errorLower.contains('network') || 
        errorLower.contains('connection')) {
      return localizations.networkError;
    }
    
    // Errori generici di login/registrazione
    if (errorLower.contains('login') || errorLower.contains('sign in')) {
      return localizations.loginFailed;
    }
    
    if (errorLower.contains('register') || errorLower.contains('sign up')) {
      return localizations.registrationFailed;
    }
    
    if (errorLower.contains('logout') || errorLower.contains('sign out')) {
      return localizations.logoutFailed;
    }
    
    // Fallback per errori sconosciuti
    return localizations.unknownError;
  }
}