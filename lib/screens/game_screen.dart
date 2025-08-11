import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/models/game_models.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _ScoreButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final bool isSelected;
  final Color borderColor;
  final VoidCallback onPressed;

  const _ScoreButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.isSelected,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        elevation: isSelected ? 6 : 2,
        minimumSize: const Size(40, 40),
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isSelected
              ? BorderSide(color: borderColor, width: 3)
              : BorderSide.none,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
          shadows: isSelected ? [
            const Shadow(
              color: Colors.black,
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ] : null,
        ),
      ),
    );
  }
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
            content: Text('Seleziona tutti i punteggi'),
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
                return Text('Volée ${state.currentVolley} - ${_getGameTitle(state.gameType)}');
              }
              return const Text('Gioco in Corso');
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
                        child: const Text('Valida Volée'),
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
            'Attuale: $currentParticipant',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Punteggio Attuale: $currentTotal',
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
              ? '**Volée Divisoria**'
              : '**Volée Moltiplicatrice**',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: state.currentVolley % 2 == 1 ? Colors.red : Colors.green,
          ),
        );
      case GameType.classica:
        return const Text(
          'Ogni arciero tira 3 frecce → somma 6 valori',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        );
      case GameType.bull:
        return Text(
          state.currentVolley % 2 == 1
              ? 'Arciere A 3 frecce – Arciere B la Bull'
              : 'Arciere B 3 frecce – Arciere A la Bull',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        );
      case GameType.impact:
        return Text(
          state.currentVolley % 2 == 1
              ? 'Arciere A 3 frecce – Arciere B 1 target'
              : 'Arciere B 3 frecce – Arciere A 1 target',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        );
      case GameType.solo:
        return const Text(
          '3 frecce (1-10 o M) – somma punteggio',
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
            'Seleziona Punteggi:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _getRequiredArrowsCount(state.gameType),
              itemBuilder: (context, arrowIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getArrowLabel(state.gameType, arrowIndex),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(11, (scoreIndex) {
                            final score = scoreIndex == 10 ? 0 : 10 - scoreIndex; // 10, 9, ..., 1, 0 (M)
                            final label = score == 0 ? 'M' : score.toString();
                            final color = _getScoreColor(score);
                            final isSelected = _scoreSelections[arrowIndex] && _selectedScores[arrowIndex] == score;
                            
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: _ScoreButton(
                                label: score == 0 ? 'M' : label,
                                color: color,
                                textColor: _getScoreTextColor(score),
                                isSelected: isSelected,
                                borderColor: _getSelectionBorderColor(score),
                                onPressed: () => _onScoreSelected(arrowIndex, score),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    // Colors for archery target rings (grouped by score ranges)
    switch (score) {
      case 10:
      case 9: return Colors.yellow; // Yellow for 10 and 9
      case 8:
      case 7: return Colors.red; // Red for 8 and 7
      case 6:
      case 5: return Colors.blue; // Blue for 6 and 5
      case 4:
      case 3: return Colors.black; // Black for 4 and 3
      case 2:
      case 1: return Colors.white; // White for 2 and 1
      case 0: return Colors.green; // Green for Miss (M)
      default: return Colors.grey;
    }
  }

  Color _getScoreTextColor(int score) {
    // Return black text for white and yellow buttons, white text for all others
    return (score == 1 || score == 2 || score == 9 || score == 10) ? Colors.black : Colors.white;
  }

  Color _getSelectionBorderColor(int score) {
    // Return contrasting border colors for better visibility
    switch (score) {
      case 10:
      case 9: return Colors.black; // Black border for yellow buttons
      case 8:
      case 7: return Colors.white; // White border for red buttons
      case 6:
      case 5: return Colors.white; // White border for blue buttons
      case 4:
      case 3: return Colors.red; // Red border for black buttons
      case 2:
      case 1: return Colors.black; // Black border for white buttons
      case 0: return Colors.white; // White border for green button (Miss)
      default: return Colors.black;
    }
  }

  String _getArrowLabel(GameType gameType, int arrowIndex) {
    final arrowNumber = arrowIndex + 1;
    
    switch (gameType) {
      case GameType.duo:
        return arrowIndex < 3 ? 'Freccia $arrowNumber' : 'Speciale';
      case GameType.classica:
        return 'Freccia $arrowNumber';
      case GameType.bull:
        return arrowIndex < 3 ? 'Freccia $arrowNumber' : 'Centro';
      case GameType.impact:
        return arrowIndex < 3 ? 'Freccia $arrowNumber' : 'Bersaglio';
      case GameType.solo:
        return 'Freccia $arrowNumber';
    }
  }

  String _getGameTitle(GameType gameType) {
    switch (gameType) {
      case GameType.duo:
        return 'Duo';
      case GameType.classica:
        return 'Classica';
      case GameType.bull:
        return 'Bull\'s Revenge';
      case GameType.impact:
        return 'Red Impact';
      case GameType.solo:
        return '18 m Singolo';
    }
  }

  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Esci dal Gioco'),
        content: const Text('Sei sicuro di voler uscire dal gioco corrente? Tutti i progressi andranno persi.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text('Esci'),
          ),
        ],
      ),
    );
  }
}