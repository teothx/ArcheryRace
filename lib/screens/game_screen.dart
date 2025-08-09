import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:archery_race/bloc/game_bloc.dart';
import 'package:archery_race/models/game_models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> _selectedScores = [];
  List<bool> _scoreSelections = [];

  @override
  void initState() {
    super.initState();
    _resetScoreSelections();
  }

  void _resetScoreSelections() {
    final state = BlocProvider.of<GameBloc>(context).state;
    if (state is GameInProgress) {
      _selectedScores = List.filled(_getRequiredArrowsCount(state.gameType), 0);
      _scoreSelections = List.filled(_getRequiredArrowsCount(state.gameType), false);
    }
  }

  int _getRequiredArrowsCount(GameType gameType) {
    return gameType.requiredArrows;
  }

  void _onScoreSelected(int index, int score) {
    setState(() {
      _selectedScores[index] = score;
      _scoreSelections[index] = true;
    });
  }

  void _submitVolley() {
    final state = BlocProvider.of<GameBloc>(context).state;
    if (state is GameInProgress) {
      // Check if all scores are selected
      if (_scoreSelections.every((selected) => selected)) {
        final currentParticipant = state.participantNames[state.currentParticipantIndex];
        
        context.read<GameBloc>().add(
              AddScore(
                participantName: currentParticipant,
                scores: _selectedScores,
                volleyNumber: state.currentVolley,
              ),
            );
        
        // Reset selections for next volley
        _resetScoreSelections();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select all scores'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameFinished) {
          Navigator.of(context).pushReplacementNamed('/results');
        } else if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is GameInProgress) {
          // Reset score selections when state changes
          _resetScoreSelections();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GameInProgress) {
                return Text('Volley ${state.currentVolley} - ${_getGameTitle(state.gameType)}');
              }
              return const Text('Game in Progress');
            },
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              _showExitConfirmationDialog();
            },
          ),
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameInProgress) {
              return Column(
                children: [
                  // Game info header
                  _buildGameInfoHeader(state),
                  
                  // Score selection area
                  Expanded(
                    child: _buildScoreSelectionArea(state),
                  ),
                  
                  // Submit button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitVolley,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Validate Volley'),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGameInfoHeader(GameInProgress state) {
    final currentParticipant = state.participantNames[state.currentParticipantIndex];
    final currentTotal = state.totals[currentParticipant] ?? 0;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current: $currentParticipant',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Current Total: $currentTotal',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildGameSpecificInfo(state),
        ],
      ),
    );
  }

  Widget _buildGameSpecificInfo(GameInProgress state) {
    switch (state.gameType) {
      case GameType.duo:
        return Text(
          state.currentVolley % 2 == 1
              ? 'Odd Volley - Divisive'
              : 'Even Volley - Multiplier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: state.currentVolley % 2 == 1 ? Colors.red : Colors.green,
          ),
        );
      case GameType.bull:
        return Text(
          state.currentVolley % 2 == 1
              ? 'Archer A 3 arrows - Archer B the Bull'
              : 'Archer B 3 arrows - Archer A the Bull',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        );
      case GameType.impact:
        return Text(
          state.currentVolley % 2 == 1
              ? 'Archer A 3 arrows - Archer B target'
              : 'Archer B 3 arrows - Archer A target',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        );
      case GameType.classica:
      case GameType.solo:
        return const Text(
          'Standard scoring',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        );
    }
  }

  Widget _buildScoreSelectionArea(GameInProgress state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Scores:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _getRequiredArrowsCount(state.gameType),
              itemBuilder: (context, arrowIndex) {
                return Column(
                  children: [
                    Text(
                      _getArrowLabel(state.gameType, arrowIndex),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      value: _scoreSelections[arrowIndex] ? _selectedScores[arrowIndex] : null,
                      hint: const Text('Score'),
                      items: List.generate(11, (index) {
                        final score = index == 10 ? 0 : 10 - index; // 10, 9, ..., 1, 0 (M)
                        final label = score == 0 ? 'M' : score.toString();
                        return DropdownMenuItem<int>(
                          value: score,
                          child: Text(label),
                        );
                      }),
                      onChanged: (score) {
                        if (score != null) {
                          _onScoreSelected(arrowIndex, score);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getArrowLabel(GameType gameType, int arrowIndex) {
    final arrowNumber = arrowIndex + 1;
    
    switch (gameType) {
      case GameType.duo:
        return arrowIndex < 3 ? 'Arrow $arrowNumber' : 'Special';
      case GameType.classica:
        return 'Arrow $arrowNumber';
      case GameType.bull:
        return arrowIndex < 3 ? 'Arrow $arrowNumber' : 'Bull';
      case GameType.impact:
        return arrowIndex < 3 ? 'Arrow $arrowNumber' : 'Target';
      case GameType.solo:
        return 'Arrow $arrowNumber';
    }
  }

  String _getGameTitle(GameType gameType) {
    switch (gameType) {
      case GameType.duo:
        return 'Duo Challenge';
      case GameType.classica:
        return 'La Classica';
      case GameType.bull:
        return 'Bull\'s Revenge';
      case GameType.impact:
        return 'Red Impact';
      case GameType.solo:
        return '18m Singolo';
    }
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Game'),
        content: const Text('Are you sure you want to exit the current game? All progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}