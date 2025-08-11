import 'package:flutter_test/flutter_test.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/models/game_models.dart';

void main() {
  late GameBloc gameBloc;

  setUp(() {
    gameBloc = GameBloc();
  });

  tearDown(() {
    gameBloc.close();
  });

  group('GameBloc', () {
    test('initial state is GameInitial', () {
      expect(gameBloc.state, GameInitial());
    });

    group('InitializeGame', () {
      test('emits GameSetup with correct gameType', () {
        const gameType = GameType.duo;
        gameBloc.add(InitializeGame(gameType: gameType));

        expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
          ]),
        );
      });
    });

    group('SetupGame', () {
      test('emits GameInProgress with correct gameType', () async {
        const gameType = GameType.duo;
        gameBloc.add(InitializeGame(gameType: gameType));
        
        // Wait for the InitializeGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
          ]),
        );
        
        // Add the SetupGame event after the InitializeGame event has been processed
        gameBloc.add(const SetupGame(
          numParticipants: 2,
          numVolleys: 3,
          participantNames: const ['Alice', 'Bob'],
        ));

        // Wait for the SetupGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
          ]),
        );
      });
    });

    group('AddScore', () {
      test('calculates score correctly based on gameType', () async {
        const gameType = GameType.duo;
        gameBloc.add(InitializeGame(gameType: gameType));
        
        // Wait for the InitializeGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
          ]),
        );
        
        // Add the SetupGame event after the InitializeGame event has been processed
        gameBloc.add(const SetupGame(
          numParticipants: 2,
          numVolleys: 3,
          participantNames: const ['Alice', 'Bob'],
        ));

        // Wait for the SetupGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
          ]),
        );
        
        // Add the AddScore event after the SetupGame event has been processed
        gameBloc.add(const AddScore(
          participantName: 'Alice',
          scores: const [10, 9, 8, 7],
          volleyNumber: 1,
        ));

        // Wait for the AddScore event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [27], 'Bob': []},
              totals: const {'Alice': 27, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 1,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
          ]),
        );
      });
    });

    group('FinishGame', () {
      test('emits GameFinished with correct gameType', () async {
        const gameType = GameType.duo;
        gameBloc.add(InitializeGame(gameType: gameType));
        
        // Wait for the InitializeGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
          ]),
        );
        
        // Add the SetupGame event after the InitializeGame event has been processed
        gameBloc.add(const SetupGame(
          numParticipants: 2,
          numVolleys: 3,
          participantNames: const ['Alice', 'Bob'],
        ));

        // Wait for the SetupGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
          ]),
        );
        
        // Add the AddScore event after the SetupGame event has been processed
        gameBloc.add(const AddScore(
          participantName: 'Alice',
          scores: const [10, 9, 8, 7],
          volleyNumber: 1,
        ));

        // Wait for the AddScore event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [27], 'Bob': []},
              totals: const {'Alice': 27, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 1,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
          ]),
        );
        
        // Add the FinishGame event after the AddScore event has been processed
        gameBloc.add(FinishGame());

        // Wait for the FinishGame event to be processed
        await expectLater(
          gameBloc.stream,
          emitsInOrder([
            isA<GameLoading>(),
            GameSetup(gameType: gameType),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [], 'Bob': []},
              totals: const {'Alice': 0, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 0,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
            isA<GameLoading>(),
            GameInProgress(
              gameType: gameType,
              scores: const {'Alice': [27], 'Bob': []},
              totals: const {'Alice': 27, 'Bob': 0},
              currentVolley: 1,
              currentParticipantIndex: 1,
              participantNames: ['Alice', 'Bob'],
              numVolleys: 3,
            ),
            isA<GameLoading>(),
            GameFinished(
              gameType: gameType,
              scores: const {'Alice': [27], 'Bob': []},
              totals: const {'Alice': 27, 'Bob': 0},
              participantNames: ['Alice', 'Bob'],
            ),
          ]),
        );
      });
    });
  });
}