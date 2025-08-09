import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:archery_race/models/game_models.dart';

// Events
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class InitializeGame extends GameEvent {
  final GameType gameType;

  const InitializeGame({
    required this.gameType,
  });

  @override
  List<Object> get props => [gameType];
}

class SetupGame extends GameEvent {
  final int numParticipants;
  final int numVolleys;
  final List<String> participantNames;

  const SetupGame({
    required this.numParticipants,
    required this.numVolleys,
    required this.participantNames,
  });

  @override
  List<Object> get props => [numParticipants, numVolleys, participantNames];
}

class AddScore extends GameEvent {
  final String participantName;
  final List<int> scores;
  final int volleyNumber;

  const AddScore({
    required this.participantName,
    required this.scores,
    required this.volleyNumber,
  });

  @override
  List<Object> get props => [participantName, scores, volleyNumber];
}

class NextVolley extends GameEvent {}

class FinishGame extends GameEvent {}

class SaveGameResults extends GameEvent {}

class LoadGameHistory extends GameEvent {}

// States
abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameSetup extends GameState {
  final GameType gameType;

  const GameSetup({
    required this.gameType,
  });

  @override
  List<Object> get props => [gameType];
}

class GameInProgress extends GameState {
  final GameType gameType;
  final Map<String, List<int>> scores;
  final Map<String, int> totals;
  final int currentVolley;
  final int currentParticipantIndex;
  final List<String> participantNames;
  final int numVolleys;

  const GameInProgress({
    required this.gameType,
    required this.scores,
    required this.totals,
    required this.currentVolley,
    required this.currentParticipantIndex,
    required this.participantNames,
    required this.numVolleys,
  });

  @override
  List<Object> get props => [
        gameType,
        scores,
        totals,
        currentVolley,
        currentParticipantIndex,
        participantNames,
        numVolleys,
      ];
}

class GameFinished extends GameState {
  final GameType gameType;
  final Map<String, List<int>> scores;
  final Map<String, int> totals;
  final List<String> participantNames;
  final List<Map<String, dynamic>> gameHistory;

  const GameFinished({
    required this.gameType,
    required this.scores,
    required this.totals,
    required this.participantNames,
    required this.gameHistory,
  });

  @override
  List<Object> get props => [
        gameType,
        scores,
        totals,
        participantNames,
        gameHistory,
      ];
}

class GameError extends GameState {
  final String message;

  const GameError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

// BLoC
class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<InitializeGame>(_onInitializeGame);
    on<SetupGame>(_onSetupGame);
    on<AddScore>(_onAddScore);
    on<NextVolley>(_onNextVolley);
    on<FinishGame>(_onFinishGame);
    on<SaveGameResults>(_onSaveGameResults);
    on<LoadGameHistory>(_onLoadGameHistory);
  }

  void _onInitializeGame(
    InitializeGame event,
    Emitter<GameState> emit,
  ) {
    emit(GameLoading());
    try {
      emit(GameSetup(gameType: event.gameType));
    } catch (e) {
      emit(GameError(message: 'Failed to initialize game: ${e.toString()}'));
    }
  }

  void _onSetupGame(
    SetupGame event,
    Emitter<GameState> emit,
  ) {
    emit(GameLoading());
    try {
      final currentState = state as GameSetup;
      final scores = <String, List<int>>{};
      final totals = <String, int>{};

      for (final name in event.participantNames) {
        scores[name] = [];
        totals[name] = 0;
      }

      emit(GameInProgress(
        gameType: currentState.gameType,
        scores: scores,
        totals: totals,
        currentVolley: 1,
        currentParticipantIndex: 0,
        participantNames: event.participantNames,
        numVolleys: event.numVolleys,
      ));
    } catch (e) {
      emit(GameError(message: 'Failed to setup game: ${e.toString()}'));
    }
  }

  void _onAddScore(
    AddScore event,
    Emitter<GameState> emit,
  ) {
    try {
      final currentState = state as GameInProgress;
      final scores = Map<String, List<int>>.from(currentState.scores);
      final totals = Map<String, int>.from(currentState.totals);

      // Calculate score based on game type
      int calculatedScore = _calculateScore(
        currentState.gameType,
        event.scores,
        event.volleyNumber,
      );

      // Add score to participant's scores
      scores[event.participantName] = List<int>.from(scores[event.participantName] ?? [])
        ..add(calculatedScore);
      
      // Update total
      totals[event.participantName] = (totals[event.participantName] ?? 0) + calculatedScore;

      // Move to next participant or volley
      int nextParticipantIndex = currentState.currentParticipantIndex + 1;
      int nextVolley = currentState.currentVolley;

      if (nextParticipantIndex >= currentState.participantNames.length) {
        nextParticipantIndex = 0;
        nextVolley++;
      }

      // Check if game is finished
      if (nextVolley > currentState.numVolleys) {
        emit(GameFinished(
          gameType: currentState.gameType,
          scores: scores,
          totals: totals,
          participantNames: currentState.participantNames,
          gameHistory: [],
        ));
      } else {
        emit(GameInProgress(
          gameType: currentState.gameType,
          scores: scores,
          totals: totals,
          currentVolley: nextVolley,
          currentParticipantIndex: nextParticipantIndex,
          participantNames: currentState.participantNames,
          numVolleys: currentState.numVolleys,
        ));
      }
    } catch (e) {
      emit(GameError(message: 'Failed to add score: ${e.toString()}'));
    }
  }

  void _onNextVolley(
    NextVolley event,
    Emitter<GameState> emit,
  ) {
    try {
      final currentState = state as GameInProgress;
      
      emit(GameInProgress(
        gameType: currentState.gameType,
        scores: currentState.scores,
        totals: currentState.totals,
        currentVolley: currentState.currentVolley + 1,
        currentParticipantIndex: 0,
        participantNames: currentState.participantNames,
        numVolleys: currentState.numVolleys,
      ));
    } catch (e) {
      emit(GameError(message: 'Failed to move to next volley: ${e.toString()}'));
    }
  }

  void _onFinishGame(
    FinishGame event,
    Emitter<GameState> emit,
  ) {
    try {
      final currentState = state as GameInProgress;
      
      emit(GameFinished(
        gameType: currentState.gameType,
        scores: currentState.scores,
        totals: currentState.totals,
        participantNames: currentState.participantNames,
        gameHistory: [],
      ));
    } catch (e) {
      emit(GameError(message: 'Failed to finish game: ${e.toString()}'));
    }
  }

  void _onSaveGameResults(
    SaveGameResults event,
    Emitter<GameState> emit,
  ) async {
    try {
      final currentState = state as GameFinished;
      
      // Save game results to shared preferences
      final prefs = await SharedPreferences.getInstance();
      final gameHistory = prefs.getStringList('gameHistory') ?? [];
      
      final gameResult = {
        'gameType': currentState.gameType.toString(),
        'date': DateTime.now().toIso8601String(),
        'participants': currentState.participantNames,
        'totals': currentState.totals,
      };
      
      gameHistory.add(gameResult.toString());
      await prefs.setStringList('gameHistory', gameHistory);
      
      emit(currentState);
    } catch (e) {
      emit(GameError(message: 'Failed to save game results: ${e.toString()}'));
    }
  }

  void _onLoadGameHistory(
    LoadGameHistory event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final gameHistoryStrings = prefs.getStringList('gameHistory') ?? [];
      
      final gameHistory = <Map<String, dynamic>>[];
      for (final historyString in gameHistoryStrings) {
        // In a real app, you would properly parse the string back to a map
        // For now, we'll just create a placeholder
        gameHistory.add({
          'gameType': 'Unknown',
          'date': DateTime.now().toIso8601String(),
          'participants': [],
          'totals': {},
        });
      }
      
      if (state is GameFinished) {
        final currentState = state as GameFinished;
        emit(GameFinished(
          gameType: currentState.gameType,
          scores: currentState.scores,
          totals: currentState.totals,
          participantNames: currentState.participantNames,
          gameHistory: gameHistory,
        ));
      } else {
        emit(GameInitial());
      }
    } catch (e) {
      emit(GameError(message: 'Failed to load game history: ${e.toString()}'));
    }
  }

  int _calculateScore(GameType gameType, List<int> scores, int volleyNumber) {
    switch (gameType) {
      case GameType.duo:
        return _calculateDuoScore(scores, volleyNumber);
      case GameType.classica:
        return _calculateClassicaScore(scores);
      case GameType.bull:
        return _calculateBullScore(scores);
      case GameType.impact:
        return _calculateImpactScore(scores);
      case GameType.solo:
        return _calculateSoloScore(scores);
    }
  }

  int _calculateDuoScore(List<int> scores, int volleyNumber) {
    if (scores.length < 4) return 0;
    
    final sumThree = scores.take(3).reduce((value, element) => value + element);
    final lastScore = scores[3];
    
    // Calculate divisor based on last score
    final divisor = _calculateDuoDivisor(lastScore);
    
    // Calculate multiplier based on last score
    final multiplier = _calculateDuoMultiplier(lastScore);
    
    // Apply divisor or multiplier based on volley number
    if (volleyNumber % 2 == 1) {
      // Odd volley - divisor
      return (sumThree / divisor).ceil();
    } else {
      // Even volley - multiplier
      return (sumThree * multiplier).ceil();
    }
  }

  double _calculateDuoDivisor(int score) {
    if (score >= 9) return 1;
    if (score >= 7) return 1.5;
    return 2;
  }

  double _calculateDuoMultiplier(int score) {
    if (score >= 9) return 2;
    if (score >= 7) return 1.5;
    return 1;
  }

  int _calculateClassicaScore(List<int> scores) {
    return scores.reduce((value, element) => value + element);
  }

  int _calculateBullScore(List<int> scores) {
    if (scores.length < 4) return 0;
    
    final sumThree = scores.take(3).reduce((value, element) => value + element);
    final bullScore = scores[3];
    
    if (bullScore == 0) return 0;
    if (bullScore == 10) return sumThree * 3;
    if (bullScore >= 8) return sumThree * 2;
    if (bullScore >= 6) return (sumThree * 1.5).toInt();
    return sumThree;
  }

  int _calculateImpactScore(List<int> scores) {
    if (scores.length < 4) return 0;
    
    final sumThree = scores.take(3).reduce((value, element) => value + element);
    final targetScore = scores[3];
    
    return targetScore >= 7 ? sumThree * 2 : sumThree;
  }

  int _calculateSoloScore(List<int> scores) {
    return scores.reduce((value, element) => value + element);
  }
}