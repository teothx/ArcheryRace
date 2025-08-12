import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:arrowclash/utils/supabase_config.dart';

// Events
abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class CheckConnectivity extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult result;

  const ConnectivityChanged(this.result);

  @override
  List<Object> get props => [result];
}

class SyncPendingData extends ConnectivityEvent {}

// States
abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityOnline extends ConnectivityState {
  final bool hasSupabaseConnection;

  const ConnectivityOnline({this.hasSupabaseConnection = false});

  @override
  List<Object> get props => [hasSupabaseConnection];
}

class ConnectivityOffline extends ConnectivityState {
  final bool hasPendingData;

  const ConnectivityOffline({this.hasPendingData = false});

  @override
  List<Object> get props => [hasPendingData];
}

class ConnectivitySyncing extends ConnectivityState {}

// BLoC
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  final SupabaseClient _supabase = SupabaseConfig.client;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);
    on<SyncPendingData>(_onSyncPendingData);

    // Avvia il monitoraggio della connettività
    _startConnectivityMonitoring();
  }

  void _startConnectivityMonitoring() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        add(ConnectivityChanged(result));
      },
    );
    
    // Controlla lo stato iniziale
    add(CheckConnectivity());
  }

  Future<void> _onCheckConnectivity(
    CheckConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      add(ConnectivityChanged(connectivityResult));
    } catch (e) {
      emit(const ConnectivityOffline());
    }
  }

  Future<void> _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    if (event.result == ConnectivityResult.none) {
      // TODO: Controlla se ci sono dati in attesa di sincronizzazione
      emit(const ConnectivityOffline(hasPendingData: false));
    } else {
      // Testa la connessione a Supabase
      final hasSupabaseConnection = await _testSupabaseConnection();
      emit(ConnectivityOnline(hasSupabaseConnection: hasSupabaseConnection));
      
      // Se c'è connessione a Supabase, sincronizza i dati in attesa
      if (hasSupabaseConnection) {
        add(SyncPendingData());
      }
    }
  }

  Future<void> _onSyncPendingData(
    SyncPendingData event,
    Emitter<ConnectivityState> emit,
  ) async {
    if (state is ConnectivityOnline && 
        (state as ConnectivityOnline).hasSupabaseConnection) {
      emit(ConnectivitySyncing());
      
      try {
        // TODO: Implementare la sincronizzazione dei dati locali
        await _syncLocalData();
        
        emit(const ConnectivityOnline(hasSupabaseConnection: true));
      } catch (e) {
        emit(const ConnectivityOnline(hasSupabaseConnection: true));
      }
    }
  }

  Future<bool> _testSupabaseConnection() async {
    try {
      // Testa la connessione facendo una query semplice
      await _supabase.from('games').select('id').limit(1);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _syncLocalData() async {
    // TODO: Implementare la sincronizzazione dei dati salvati localmente
    // Questo sarà implementato quando aggiungeremo il salvataggio locale
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}