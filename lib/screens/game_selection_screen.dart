import 'package:flutter/material.dart';

class GameSelectionScreen extends StatelessWidget {
  const GameSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selezione Gioco'),
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
              'Seleziona una Modalità di Gioco',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    children: [
                  _buildGameCard(
                    context,
                    title: 'Archery Duo Challenge',
                    description: 'Squadra mista: principiante + veterano',
                    icon: Icons.people,
                    color: Colors.blue,
                    gameType: 'duo',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'La Classica',
                    description: 'Ogni arciero tira 3 frecce → somma 6 valori per squadra',
                    icon: Icons.sports,
                    color: Colors.green,
                    gameType: 'classica',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'Bull\'s Revenge',
                    description: 'Volée dispari: Arciere A 3 frecce, Arciere B la Bull',
                    icon: Icons.track_changes,
                    color: Colors.red,
                    gameType: 'bull',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: 'Red Impact',
                    description: 'Volée dispari: Arciere A 3 frecce, Arciere B 1 target',
                    icon: Icons.center_focus_strong,
                    color: Colors.orange,
                    gameType: 'impact',
                  ),
                  const SizedBox(height: 16),
                  _buildGameCard(
                    context,
                    title: '18 m Singolo',
                    description: 'Gara individuale – 3 frecce per volée',
                    icon: Icons.person,
                    color: Colors.purple,
                    gameType: 'solo',
                  ),
                    ],
                  ),
                ),
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}