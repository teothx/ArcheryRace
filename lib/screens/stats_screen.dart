import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:arrowclash/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Map<String, dynamic>> _gameHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGameHistory();
  }

  Future<void> _loadGameHistory() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final gameHistoryStrings = prefs.getStringList('gameHistory') ?? [];
      
      final gameHistory = <Map<String, dynamic>>[];
      for (final historyString in gameHistoryStrings) {
        try {
          // Try to parse the string as JSON
          final gameData = jsonDecode(historyString) as Map<String, dynamic>;
          gameHistory.add(gameData);
        } catch (e) {
          // If parsing fails, skip this entry
          debugPrint('Error parsing game history: $e');
        }
      }
      
      setState(() {
        _gameHistory = gameHistory;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading game history: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Statistiche'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadGameHistory,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _gameHistory.isEmpty
                ? _buildEmptyState()
                : _buildStatsContent(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bar_chart,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'Nessuna cronologia di giochi disponibile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Gioca qualche partita per vedere le tue statistiche qui',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: const Text('Gioca una Partita'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards
          _buildSummaryCards(),
          
          const SizedBox(height: 24),
          
          // Game type distribution chart
          _buildGameTypeChart(),
          
          const SizedBox(height: 24),
          
          // Recent games
          _buildRecentGames(),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    // Calculate statistics
    final totalGames = _gameHistory.length;
    final gameTypes = _gameHistory.map((game) => game['gameType']?.toString() ?? 'Unknown').toSet();
    final mostPlayedGameType = _getMostPlayedGameType();
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Partite Totali',
            value: totalGames.toString(),
            icon: Icons.sports_score,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Tipi di Gioco',
            value: gameTypes.length.toString(),
            icon: Icons.category,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            title: 'Più Giocato',
            value: mostPlayedGameType,
            icon: Icons.star,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMostPlayedGameType() {
    if (_gameHistory.isEmpty) return 'None';
    
    final gameTypeCounts = <String, int>{};
    for (final game in _gameHistory) {
      final gameType = game['gameType']?.toString() ?? 'Unknown';
      gameTypeCounts[gameType] = (gameTypeCounts[gameType] ?? 0) + 1;
    }
    
    String mostPlayed = 'Unknown';
    int maxCount = 0;
    
    gameTypeCounts.forEach((gameType, count) {
      if (count > maxCount) {
        mostPlayed = gameType;
        maxCount = count;
      }
    });
    
    return _formatGameType(mostPlayed);
  }

  String _formatGameType(String gameType) {
    switch (gameType) {
      case 'GameType.duo':
        return 'Duo Challenge';
      case 'GameType.classica':
        return 'La Classica';
      case 'GameType.bull':
        return 'Bull\'s Revenge';
      case 'GameType.impact':
        return 'Red Impact';
      case 'GameType.solo':
        return '18m Singolo';
      default:
        return 'Unknown';
    }
  }

  Widget _buildGameTypeChart() {
    // Count games by type
    final gameTypeCounts = <String, int>{};
    for (final game in _gameHistory) {
      final gameType = game['gameType']?.toString() ?? 'Unknown';
      gameTypeCounts[gameType] = (gameTypeCounts[gameType] ?? 0) + 1;
    }
    
    // Prepare data for chart
    final chartData = <PieChartSectionData>[];
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];
    
    int colorIndex = 0;
    gameTypeCounts.forEach((gameType, count) {
      chartData.add(
        PieChartSectionData(
          color: colors[colorIndex % colors.length],
          value: count.toDouble(),
          title: '${_formatGameType(gameType)}\n$count',
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          radius: 100,
        ),
      );
      colorIndex++;
    });
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Distribuzione Tipi di Gioco',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: chartData,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentGames() {
    // Sort games by date (newest first)
    final sortedGames = List<Map<String, dynamic>>.from(_gameHistory);
    sortedGames.sort((a, b) {
      final dateA = DateTime.tryParse(a['date']?.toString() ?? '') ?? DateTime.now();
      final dateB = DateTime.tryParse(b['date']?.toString() ?? '') ?? DateTime.now();
      return dateB.compareTo(dateA);
    });
    
    // Take only the last 5 games
    final recentGames = sortedGames.take(5).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Partite Recenti',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentGames.length,
          itemBuilder: (context, index) {
            final game = recentGames[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(_formatGameType(game['gameType']?.toString() ?? 'Unknown')),
                subtitle: Text(_formatDate(game['date']?.toString() ?? '')),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _showGameDetailsDialog(game);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Unknown date';
    }
  }

  void _showGameDetailsDialog(Map<String, dynamic> game) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_formatGameType(game['gameType']?.toString() ?? 'Unknown')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${_formatDate(game['date']?.toString() ?? '')}'),
            const SizedBox(height: 16),
            const Text(
              'Partecipanti:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Display participants and their scores if available
            if (game['participants'] != null && game['totals'] != null)
              ..._buildParticipantScores(game),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Chiudi'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildParticipantScores(Map<String, dynamic> game) {
    final participants = game['participants'] as List?;
    final totals = game['totals'] as Map?;
    
    if (participants == null || totals == null) {
      return [const Text('Nessun dato di punteggio disponibile')];
    }
    
    return participants.map((participant) {
      final score = totals[participant]?.toString() ?? '0';
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text('$participant: $score'),
      );
    }).toList();
  }
}