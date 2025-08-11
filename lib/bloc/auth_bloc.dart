import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../utils/supabase_config.dart';
import '../utils/auth_error_handler.dart';
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

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = _supabase.auth.currentUser;
      if (user != null) {
        emit(Authenticated(
          id: user.id,
          name: user.userMetadata?['name'] ?? user.email?.split('@')[0] ?? 'Utente',
          email: user.email ?? '',
        ));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );
      
      final user = response.user;
      if (user != null) {
        emit(Authenticated(
          id: user.id,
          name: user.userMetadata?['name'] ?? user.email?.split('@')[0] ?? 'Utente',
          email: user.email ?? '',
        ));
      } else {
        final errorMessage = AuthErrorHandler.getLocalizedErrorMessage('login failed', localizations);
        emit(AuthError(message: errorMessage));
      }
    } catch (e) {
      final errorMessage = AuthErrorHandler.getLocalizedErrorMessage(e.toString(), localizations);
      emit(AuthError(message: errorMessage));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signUp(
        email: event.email,
        password: event.password,
        data: {'name': event.name},
      );
      
      final user = response.user;
      if (user != null) {
        emit(Authenticated(
          id: user.id,
          name: event.name,
          email: user.email ?? '',
        ));
      } else {
        final errorMessage = AuthErrorHandler.getLocalizedErrorMessage('registration failed', localizations);
        emit(AuthError(message: errorMessage));
      }
    } catch (e) {
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
      emit(Unauthenticated());
    } catch (e) {
      final errorMessage = AuthErrorHandler.getLocalizedErrorMessage(e.toString(), localizations);
      emit(AuthError(message: errorMessage));
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