// This file contains data models related to games

class GameResult {
  final String gameType;
  final DateTime date;
  final List<String> participants;
  final Map<String, int> totals;
  final Map<String, List<int>> scores;

  GameResult({
    required this.gameType,
    required this.date,
    required this.participants,
    required this.totals,
    required this.scores,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameType': gameType,
      'date': date.toIso8601String(),
      'participants': participants,
      'totals': totals,
      'scores': scores,
    };
  }

  factory GameResult.fromJson(Map<String, dynamic> json) {
    return GameResult(
      gameType: json['gameType'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      participants: List<String>.from(json['participants'] ?? []),
      totals: Map<String, int>.from(json['totals'] ?? {}),
      scores: json['scores'] != null
          ? Map<String, List<int>>.from(
              (json['scores'] as Map).map(
                (key, value) => MapEntry(key, List<int>.from(value)),
              ),
            )
          : {},
    );
  }
}

class Player {
  final String name;
  final int totalScore;
  final List<int> scores;

  Player({
    required this.name,
    required this.totalScore,
    required this.scores,
  });

  factory Player.fromGameResult(String name, GameResult gameResult) {
    return Player(
      name: name,
      totalScore: gameResult.totals[name] ?? 0,
      scores: gameResult.scores[name] ?? [],
    );
  }
}

enum GameType {
  duo,
  classica,
  bull,
  impact,
  solo,
}

extension GameTypeExtension on GameType {
  String get displayName {
    switch (this) {
      case GameType.duo:
        return 'Archery Duo Challenge';
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

  String get rules {
    switch (this) {
      case GameType.duo:
        return '''
• Squadra mista: principiante + veterano
• Volée dispari: principiante 3 frecce, veterano 1 freccia = **divisore**
• Volée pari: veterano 3 frecce, principiante 1 freccia = **moltiplicatore**
• Numero di volée pari – punteggio cumulativo
        ''';
      case GameType.classica:
        return '''
• Ogni arciero tira 3 frecce → somma 6 valori per squadra
• Nessun moltiplicatore
• Numero di volée pari
        ''';
      case GameType.bull:
        return '''
• **Volée dispari**: Arciere A 3 frecce, Arciere B la Bull
• **Volée pari**: ruoli invertiti
• **Punteggio squadra** = (somma 3 frecce) × moltiplicatore Bull
  - 10 → ×3, 9-8 → ×2, 7-6 → ×1.5, 5-1 → ×1, 0 (M) → 0
        ''';
      case GameType.impact:
        return '''
• **Volée dispari**: Arciere A 3 frecce, Arciere B 1 target
• **Volée pari**: ruoli invertiti
• Target 7-10 → ×2 sul punteggio base
• 1-6 o M → nessun effetto
        ''';
      case GameType.solo:
        return '''
• Gara individuale – 3 frecce per volée
• Valori 1-10 o M (0) – punteggio cumulativo
        ''';
    }
  }

  int get requiredArrows {
    switch (this) {
      case GameType.duo:
        return 4; // 3 arrows + 1 special arrow
      case GameType.classica:
        return 6; // 6 arrows total
      case GameType.bull:
        return 4; // 3 arrows + 1 bull
      case GameType.impact:
        return 4; // 3 arrows + 1 target
      case GameType.solo:
        return 3; // 3 arrows
    }
  }

  bool get isTeamGame {
    switch (this) {
      case GameType.duo:
      case GameType.classica:
      case GameType.bull:
      case GameType.impact:
        return true;
      case GameType.solo:
        return false;
    }
  }

  String get participantLabel {
    return isTeamGame ? 'Team' : 'Archer';
  }
}