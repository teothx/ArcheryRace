import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/models/game_models.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Risultati Gioco'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state is GameFinished) {
              return Column(
                children: [
                  // Results table
                  Expanded(
                    flex: 2,
                    child: _buildResultsTable(state),
                  ),
                  
                  // Score evolution chart
                  Expanded(
                    flex: 2,
                    child: _buildScoreChart(state),
                  ),
                  
                  // Action buttons
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Leaderboard button

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed('/home');
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Torna alla Home'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _saveResults(state);
                                  _showResultsSavedDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Salva Risultati'),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildResultsTable(GameFinished state) {
    // Sort participants by total score (descending)
    final sortedParticipants = List<String>.from(state.participantNames);
    sortedParticipants.sort((a, b) {
      final scoreA = state.totals[a] ?? 0;
      final scoreB = state.totals[b] ?? 0;
      return scoreB.compareTo(scoreA);
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_getGameTitle(state.gameType)} - Risultati Finali',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columnSpacing: 16,
                headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Posizione',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Nome',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Totale',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: List.generate(sortedParticipants.length, (index) {
                  final participant = sortedParticipants[index];
                  final total = state.totals[participant] ?? 0;
                  
                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(participant)),
                      DataCell(Text(total.toString())),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChart(GameFinished state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evoluzione Punteggio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final volleyNumber = value.toInt() + 1;
                        return Text('Volée $volleyNumber');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                minX: 0,
                maxX: math.max(0, (state.scores[state.participantNames.first]?.length ?? 1) - 1).toDouble(),
                minY: 0,
                lineBarsData: state.participantNames.map((participant) {
                  final scores = state.scores[participant] ?? [];
                  final cumulativeScores = <int>[];
                  int sum = 0;
                  
                  for (final score in scores) {
                    sum += score;
                    cumulativeScores.add(sum);
                  }
                  
                  return LineChartBarData(
                    spots: cumulativeScores
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble()))
                        .toList(),
                    isCurved: true,
                    color: _getParticipantColor(state.participantNames.indexOf(participant)),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getParticipantColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.amber,
      Colors.indigo,
    ];
    return colors[index % colors.length];
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

  void _saveResults(GameFinished state) {
    context.read<GameBloc>().add(SaveGameResults());
  }

  void _showResultsSavedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Risultati Salvati'),
        content: const Text('I risultati del gioco sono stati salvati con successo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }


}