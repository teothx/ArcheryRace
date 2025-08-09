import 'package:flutter/material.dart';

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Selection'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Game Mode',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildGameCard(
                    context,
                    title: 'Archery Duo Challenge',
                    description: 'Mixed team: beginner + veteran',
                    icon: Icons.people,
                    color: Colors.blue,
                    gameType: 'duo',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'La Classica',
                    description: 'Classic archery game',
                    icon: Icons.sports,
                    color: Colors.green,
                    gameType: 'classica',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'Bull\'s Revenge',
                    description: 'Bull\'s eye challenge',
                    icon: Icons.track_changes,
                    color: Colors.red,
                    gameType: 'bull',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'Red Impact',
                    description: 'Target impact game',
                    icon: Icons.center_focus_strong,
                    color: Colors.orange,
                    gameType: 'impact',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: '18m Singolo',
                    description: 'Individual 18m game',
                    icon: Icons.person,
                    color: Colors.purple,
                    gameType: 'solo',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String gameType,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            '/game_rules',
            arguments: gameType,
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}