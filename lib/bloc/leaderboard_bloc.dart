import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:arrowclash/models/leaderboard_models.dart';
import 'package:arrowclash/utils/storage_service.dart';

// Events
abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object> get props => [];
}

class LoadLeaderboard extends LeaderboardEvent {}

class AddGameResult extends LeaderboardEvent {
  final String playerId;
  final String playerName;
  final int score;

  const AddGameResult({
    required this.playerId,
    required this.playerName,
    required this.score,
  });

  @override
  List<Object> get props => [playerId, playerName, score];
}

class ClearLeaderboard extends LeaderboardEvent {}

// States
abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object> get props => [];
}

class LeaderboardInitial extends LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final Leaderboard leaderboard;

  const LeaderboardLoaded({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  static const String _leaderboardKey = 'provisional_leaderboard';

  LeaderboardBloc() : super(LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<AddGameResult>(_onAddGameResult);
    on<ClearLeaderboard>(_onClearLeaderboard);
  }

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(LeaderboardLoading());
    try {
      final leaderboard = await _getStoredLeaderboard();
      emit(LeaderboardLoaded(leaderboard: leaderboard));
    } catch (e) {
      emit(LeaderboardError(message: 'Errore nel caricamento della classifica: $e'));
    }
  }

  Future<void> _onAddGameResult(
    AddGameResult event,
    Emitter<LeaderboardState> emit,
  ) async {
    try {
      final currentLeaderboard = await _getStoredLeaderboard();
      final updatedLeaderboard = _addResultToLeaderboard(
        currentLeaderboard,
        event.playerId,
        event.playerName,
        event.score,
      );
      
      await _saveLeaderboard(updatedLeaderboard);
      emit(LeaderboardLoaded(leaderboard: updatedLeaderboard));
    } catch (e) {
      emit(LeaderboardError(message: 'Errore nell\'aggiornamento della classifica: $e'));
    }
  }

  Future<void> _onClearLeaderboard(
    ClearLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    try {
      await StorageService.clearData(_leaderboardKey);
      final emptyLeaderboard = Leaderboard(
        entries: [],
        lastUpdated: DateTime.now(),
        isProvisional: true,
      );
      emit(LeaderboardLoaded(leaderboard: emptyLeaderboard));
    } catch (e) {
      emit(LeaderboardError(message: 'Errore nella cancellazione della classifica: $e'));
    }
  }

  Future<Leaderboard> _getStoredLeaderboard() async {
    try {
      final data = await StorageService.getData(_leaderboardKey);
      if (data != null) {
        final json = Map<String, dynamic>.from(data);
        return Leaderboard.fromJson(json);
      }
    } catch (e) {
      print('DEBUG: Error loading stored leaderboard: $e');
    }
    
    // Ritorna una classifica vuota se non ci sono dati salvati
    return Leaderboard(
      entries: [],
      lastUpdated: DateTime.now(),
      isProvisional: true,
    );
  }

  Future<void> _saveLeaderboard(Leaderboard leaderboard) async {
    try {
      await StorageService.saveData(_leaderboardKey, leaderboard.toJson());
      print('DEBUG: Leaderboard saved successfully');
    } catch (e) {
      print('DEBUG: Error saving leaderboard: $e');
      throw e;
    }
  }

  Leaderboard _addResultToLeaderboard(
    Leaderboard currentLeaderboard,
    String playerId,
    String playerName,
    int score,
  ) {
    final entries = List<LeaderboardEntry>.from(currentLeaderboard.entries);
    
    // Cerca se il giocatore esiste già
    final existingIndex = entries.indexWhere((entry) => entry.playerId == playerId);
    
    if (existingIndex != -1) {
      // Aggiorna il giocatore esistente
      final existing = entries[existingIndex];
      final newTotalScore = existing.totalScore + score;
      final newGamesPlayed = existing.gamesPlayed + 1;
      final newAverageScore = newTotalScore / newGamesPlayed;
      
      entries[existingIndex] = existing.copyWith(
        totalScore: newTotalScore,
        gamesPlayed: newGamesPlayed,
        averageScore: newAverageScore,
        lastGameDate: DateTime.now(),
      );
    } else {
      // Aggiungi nuovo giocatore
      entries.add(LeaderboardEntry(
        playerId: playerId,
        playerName: playerName,
        totalScore: score,
        gamesPlayed: 1,
        averageScore: score.toDouble(),
        lastGameDate: DateTime.now(),
      ));
    }
    
    return currentLeaderboard.copyWith(
      entries: entries,
      lastUpdated: DateTime.now(),
    );
  }
}