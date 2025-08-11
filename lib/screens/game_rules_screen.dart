import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arrowclash/bloc/game_bloc.dart';
import 'package:arrowclash/models/game_models.dart';
import 'package:arrowclash/l10n/app_localizations.dart';

class GameRulesScreen extends StatelessWidget {
  const GameRulesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? gameType = ModalRoute.of(context)?.settings.arguments as String?;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_getGameTitle(gameType)),
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
            Text(
              '${_getGameTitle(gameType)} - ${localizations.rules}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: _buildRulesContent(gameType, localizations),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(localizations.back),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedGameType = _getGameTypeEnum(gameType);
                      print('Starting game with type: $selectedGameType');
                      BlocProvider.of<GameBloc>(context).add(
                        InitializeGame(gameType: selectedGameType),
                      );
                      // Navigate directly to game setup
                      print('Navigating to game setup with game type: $selectedGameType');
                      Navigator.of(context).pushReplacementNamed(
                        '/game_setup',
                        arguments: selectedGameType,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(localizations.startGame),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getGameTitle(String? gameType) {
    switch (gameType) {
      case 'duo':
        return 'Archery Duo Challenge';
      case 'classica':
        return 'La Classica';
      case 'bull':
        return 'Bull\'s Revenge';
      case 'impact':
        return 'Red Impact';
      case 'solo':
        return '18m Singolo';
      default:
        return 'Game Rules';
    }
  }

  GameType _getGameTypeEnum(String? gameType) {
    switch (gameType) {
      case 'duo':
        return GameType.duo;
      case 'classica':
        return GameType.classica;
      case 'bull':
        return GameType.bull;
      case 'impact':
        return GameType.impact;
      case 'solo':
        return GameType.solo;
      default:
        return GameType.classica;
    }
  }

  Widget _buildRulesContent(String? gameType, AppLocalizations localizations) {
    final gameTypeEnum = _getGameTypeEnum(gameType);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${localizations.rules}:',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(gameTypeEnum.rules),
      ],
    );
  }
}