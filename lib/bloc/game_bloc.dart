import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:arrowclash/models/game_models.dart';
import '../repositories/game_repository.dart';

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

class ContinueToNextVolley extends GameEvent {}

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

class VolleyCompleted extends GameState {
  final GameType gameType;
  final Map<String, List<int>> scores;
  final Map<String, int> totals;
  final int currentVolley;
  final List<String> participantNames;
  final int numVolleys;

  const VolleyCompleted({
    required this.gameType,
    required this.scores,
    required this.totals,
    required this.currentVolley,
    required this.participantNames,
    required this.numVolleys,
  });

  @override
  List<Object> get props => [
        gameType,
        scores,
        totals,
        currentVolley,
        participantNames,
        numVolleys,
      ];
}

class GameFinished extends GameState {
  final GameType gameType;
  final Map<String, List<int>> scores;
  final Map<String, int> totals;
  final List<String> participantNames;

  const GameFinished({
    required this.gameType,
    required this.scores,
    required this.totals,
    required this.participantNames,
  });

  @override
  List<Object> get props => [
        gameType,
        scores,
        totals,
        participantNames,
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
  final GameRepository _gameRepository = GameRepository();

  GameBloc() : super(GameInitial()) {
    on<InitializeGame>(_onInitializeGame);
    on<SetupGame>(_onSetupGame);
    on<AddScore>(_onAddScore);
    on<NextVolley>(_onNextVolley);
    on<ContinueToNextVolley>(_onContinueToNextVolley);
    on<FinishGame>(_onFinishGame);
    on<SaveGameResults>(_onSaveGameResults);
    on<LoadGameHistory>(_onLoadGameHistory);
  }


  void _onInitializeGame(
    InitializeGame event,
    Emitter<GameState> emit,
  ) {
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

    
    try {
      // Get the game type from the current state BEFORE emitting GameLoading
      if (state is GameSetup) {
        final gameType = (state as GameSetup).gameType;

        
        emit(GameLoading());
        
        final scores = <String, List<int>>{};
        final totals = <String, int>{};

        for (final name in event.participantNames) {
          scores[name] = [];
          totals[name] = 0;
        }

        emit(GameInProgress(
          gameType: gameType,
          scores: scores,
          totals: totals,
          currentVolley: 1,
          currentParticipantIndex: 0,
          participantNames: event.participantNames,
          numVolleys: event.numVolleys,
        ));
        

      } else {

        emit(GameError(message: 'Game not initialized. Please initialize the game first.'));
      }
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

      // Move to next participant
      int nextParticipantIndex = currentState.currentParticipantIndex + 1;

      // Check if all participants have completed this volley
      if (nextParticipantIndex >= currentState.participantNames.length) {
        // Check if this is the last volley
        if (currentState.currentVolley >= currentState.numVolleys) {
          // Last volley completed, go directly to final results
          emit(GameFinished(
            gameType: currentState.gameType,
            scores: scores,
            totals: totals,
            participantNames: currentState.participantNames,
          ));
        } else {
          // Not the last volley, show provisional leaderboard
          emit(VolleyCompleted(
            gameType: currentState.gameType,
            scores: scores,
            totals: totals,
            currentVolley: currentState.currentVolley,
            participantNames: currentState.participantNames,
            numVolleys: currentState.numVolleys,
          ));
        }
      } else {
        // Continue with next participant in same volley
        emit(GameInProgress(
          gameType: currentState.gameType,
          scores: scores,
          totals: totals,
          currentVolley: currentState.currentVolley,
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

  void _onContinueToNextVolley(
    ContinueToNextVolley event,
    Emitter<GameState> emit,
  ) {
    try {
      final currentState = state as VolleyCompleted;
      
      // Check if game is finished
      if (currentState.currentVolley >= currentState.numVolleys) {
        emit(GameFinished(
          gameType: currentState.gameType,
          scores: currentState.scores,
          totals: currentState.totals,
          participantNames: currentState.participantNames,
        ));
      } else {
        // Continue to next volley
        emit(GameInProgress(
          gameType: currentState.gameType,
          scores: currentState.scores,
          totals: currentState.totals,
          currentVolley: currentState.currentVolley + 1,
          currentParticipantIndex: 0,
          participantNames: currentState.participantNames,
          numVolleys: currentState.numVolleys,
        ));
      }
    } catch (e) {
      emit(GameError(message: 'Failed to continue to next volley: ${e.toString()}'));
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
      
      final gameResult = GameResult(
        gameType: currentState.gameType.toString(),
        date: DateTime.now(),
        participants: currentState.participantNames,
        totals: currentState.totals,
        scores: currentState.scores,
      );
      
      await _gameRepository.saveGameResult(gameResult);
      
      emit(currentState);
    } catch (e) {
      emit(GameError(message: 'Errore nel salvare i risultati: ${e.toString()}'));
    }
  }

  void _onLoadGameHistory(
    LoadGameHistory event,
    Emitter<GameState> emit,
  ) async {
    emit(GameLoading());
    try {
      await _gameRepository.getUserGameHistory();
      
      if (state is GameFinished) {
        final currentState = state as GameFinished;
        emit(GameFinished(
          gameType: currentState.gameType,
          scores: currentState.scores,
          totals: currentState.totals,
          participantNames: currentState.participantNames,
        ));
      } else {
        emit(GameInitial());
      }
    } catch (e) {
      emit(GameError(message: 'Errore nel caricare la cronologia: ${e.toString()}'));
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