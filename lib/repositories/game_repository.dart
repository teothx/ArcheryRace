import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/game_models.dart';
import '../utils/supabase_config.dart';

class GameRepository {
  final SupabaseClient _client = SupabaseConfig.client;
  final Uuid _uuid = const Uuid();

  // Salva un risultato di gioco nel database
  Future<String> saveGameResult(GameResult gameResult) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw Exception('Utente non autenticato');
      }

      final gameId = _uuid.v4();
      
      // Inserisci il gioco principale
      await _client.from('games').insert({
        'id': gameId,
        'user_id': user.id,
        'game_type': gameResult.gameType,
        'created_at': gameResult.date.toIso8601String(),
        'num_volleys': gameResult.scores.values.isNotEmpty 
            ? gameResult.scores.values.first.length 
            : 0,
      });

      // Inserisci i risultati per ogni partecipante
      for (final participant in gameResult.participants) {
        await _client.from('game_results').insert({
          'id': _uuid.v4(),
          'game_id': gameId,
          'participant_name': participant,
          'total_score': gameResult.totals[participant] ?? 0,
          'scores': gameResult.scores[participant] ?? [],
        });
      }

      return gameId;
    } catch (e) {
      throw Exception('Errore nel salvare il risultato: $e');
    }
  }

  // Recupera la cronologia dei giochi dell'utente
  Future<List<GameResult>> getUserGameHistory() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw Exception('Utente non autenticato');
      }

      // Recupera i giochi dell'utente
      final gamesResponse = await _client
          .from('games')
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      final List<GameResult> gameResults = [];

      for (final game in gamesResponse) {
        // Recupera i risultati per questo gioco
        final resultsResponse = await _client
            .from('game_results')
            .select('*')
            .eq('game_id', game['id']);

        final participants = <String>[];
        final totals = <String, int>{};
        final scores = <String, List<int>>{};

        for (final result in resultsResponse) {
          final participantName = result['participant_name'] as String;
          participants.add(participantName);
          totals[participantName] = result['total_score'] as int;
          scores[participantName] = List<int>.from(result['scores'] as List);
        }

        gameResults.add(GameResult(
          gameType: game['game_type'] as String,
          date: DateTime.parse(game['created_at'] as String),
          participants: participants,
          totals: totals,
          scores: scores,
        ));
      }

      return gameResults;
    } catch (e) {
      throw Exception('Errore nel recuperare la cronologia: $e');
    }
  }

  // Elimina un gioco
  Future<void> deleteGame(String gameId) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw Exception('Utente non autenticato');
      }

      // Elimina prima i risultati
      await _client.from('game_results').delete().eq('game_id', gameId);
      
      // Poi elimina il gioco
      await _client
          .from('games')
          .delete()
          .eq('id', gameId)
          .eq('user_id', user.id);
    } catch (e) {
      throw Exception('Errore nell\'eliminare il gioco: $e');
    }
  }

  // Ottieni statistiche utente
  Future<Map<String, dynamic>> getUserStats() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw Exception('Utente non autenticato');
      }

      final gamesResponse = await _client
          .from('games')
          .select('game_type')
          .eq('user_id', user.id);

      final gamesByType = <String, int>{};
      for (final game in gamesResponse) {
        final gameType = game['game_type'] as String;
        gamesByType[gameType] = (gamesByType[gameType] ?? 0) + 1;
      }

      return {
        'total_games': gamesResponse.length,
        'games_by_type': gamesByType,
      };
    } catch (e) {
      throw Exception('Errore nel recuperare le statistiche: $e');
    }
  }
}