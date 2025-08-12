import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/supabase_config.dart';
import '../utils/auth_error_handler.dart';
import '../utils/storage_service.dart';
import '../l10n/app_localizations.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class LogoutRequested extends AuthEvent {}

class PasswordResetRequested extends AuthEvent {
  final String email;

  const PasswordResetRequested({required this.email});

  @override
  List<Object> get props => [email];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String id;
  final String name;
  final String email;

  const Authenticated({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object> get props => [id, name, email];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class PasswordResetSuccess extends AuthState {
  final String message;

  const PasswordResetSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseClient _supabase = SupabaseConfig.client;
  final AppLocalizations localizations;

  AuthBloc({required this.localizations}) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<PasswordResetRequested>(_onPasswordResetRequested);
  }

  Future<void> _saveUserData(String id, String name, String email) async {
    await StorageService.saveUserData(id, name, email);
  }

  Future<Map<String, String>?> _getSavedUserData() async {
    return await StorageService.getUserData();
  }

  Future<void> _clearUserData() async {
    await StorageService.clearUserData();
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    print('DEBUG: CheckAuthStatus called');
    emit(AuthLoading());
    try {
      final user = _supabase.auth.currentUser;
      print('DEBUG: Current user: ${user?.id}');
      if (user != null) {
        final name = user.userMetadata?['name'] ?? user.email?.split('@')[0] ?? 'Utente';
        final email = user.email ?? '';
        
        // Salva i dati per uso offline
        await _saveUserData(user.id, name, email);
        print('DEBUG: User data saved for offline use');
        
        emit(Authenticated(
          id: user.id,
          name: name,
          email: email,
        ));
      } else {
        // Se non c'è utente online, controlla i dati salvati
        final savedData = await StorageService.getUserData();
        print('DEBUG: Saved data: $savedData');
        if (savedData != null) {
          print('DEBUG: Using saved data for authentication');
          emit(Authenticated(
            id: savedData['id']!,
            name: savedData['name']!,
            email: savedData['email']!,
          ));
        } else {
          print('DEBUG: No saved data, emitting Unauthenticated');
          emit(Unauthenticated());
        }
      }
    } catch (e) {
      print('DEBUG: Error in CheckAuthStatus: $e');
      // In caso di errore di connessione, usa i dati salvati
      final savedData = await StorageService.getUserData();
      if (savedData != null) {
        print('DEBUG: Using saved data after error');
        emit(Authenticated(
          id: savedData['id']!,
          name: savedData['name']!,
          email: savedData['email']!,
        ));
      } else {
        print('DEBUG: No saved data after error, emitting Unauthenticated');
        emit(Unauthenticated());
      }
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('DEBUG: Login requested for ${event.email}');
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      
      final user = response.user;
      print('DEBUG: Login response user: ${user?.id}');
      if (user != null) {
        final name = user.userMetadata?['name'] ?? user.email?.split('@')[0] ?? 'Utente';
        final email = user.email ?? '';
        
        // Salva i dati per uso offline
        await _saveUserData(user.id, name, email);
        print('DEBUG: User data saved after login: id=${user.id}, name=$name, email=$email');
        
        emit(Authenticated(
          id: user.id,
          name: name,
          email: email,
        ));
      } else {
        print('DEBUG: Login failed - no user returned');
        final errorMessage = AuthErrorHandler.getLocalizedErrorMessage('login failed', localizations);
        emit(AuthError(message: errorMessage));
      }
    } catch (e) {
      print('DEBUG: Login error: $e');
      final errorMessage = AuthErrorHandler.getLocalizedErrorMessage(e.toString(), localizations);
      emit(AuthError(message: errorMessage));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    print('DEBUG: Registration requested for ${event.email}');
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signUp(
        email: event.email,
        password: event.password,
        data: {'name': event.name},
      );
      
      final user = response.user;
      print('DEBUG: Registration response user: ${user?.id}');
      if (user != null) {
        final email = user.email ?? '';
        
        // Salva i dati per uso offline
        await _saveUserData(user.id, event.name, email);
        print('DEBUG: User data saved after registration: id=${user.id}, name=${event.name}, email=$email');
        
        emit(Authenticated(
          id: user.id,
          name: event.name,
          email: email,
        ));
      } else {
        print('DEBUG: Registration failed - no user returned');
        final errorMessage = AuthErrorHandler.getLocalizedErrorMessage('registration failed', localizations);
        emit(AuthError(message: errorMessage));
      }
    } catch (e) {
      print('DEBUG: Registration error: $e');
      final errorMessage = AuthErrorHandler.getLocalizedErrorMessage(e.toString(), localizations);
      emit(AuthError(message: errorMessage));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _supabase.auth.signOut();
      await _clearUserData();
      emit(Unauthenticated());
    } catch (e) {
      // Anche se il logout online fallisce, cancella i dati locali
      await _clearUserData();
      emit(Unauthenticated());
    }
  }

  Future<void> _onPasswordResetRequested(
    PasswordResetRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _supabase.auth.resetPasswordForEmail(event.email);
      emit(PasswordResetSuccess(message: localizations.resetEmailSent));
    } catch (e) {
      final errorMessage = AuthErrorHandler.getLocalizedErrorMessage(e.toString(), localizations);
      emit(AuthError(message: errorMessage));
    }
  }
}