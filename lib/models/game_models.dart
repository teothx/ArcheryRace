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
      scores: Map<String, List<int>>.from(
        (json['scores'] as Map)?.map(
          (key, value) => MapEntry(key, List<int>.from(value)),
        ) ?? {},
      ),
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
• Mixed team: beginner + veteran
• Odd volley: beginner 3 arrows, veteran 1 arrow = divisor
• Even volley: veteran 3 arrows, beginner 1 arrow = multiplier
• Number of even volleys – cumulative score
        ''';
      case GameType.classica:
        return '''
• Each archer shoots 3 arrows → sum 6 values for team
• No multiplier
• Number of even volleys
        ''';
      case GameType.bull:
        return '''
• Odd volley: Archer A 3 arrows, Archer B the Bull
• Even volley: roles reversed
• Team score = (sum of 3 arrows) × Bull multiplier
• 10 → ×3, 9-8 → ×2, 7-6 → ×1.5, 5-1 → ×1, 0 (M) → 0
        ''';
      case GameType.impact:
        return '''
• Odd volley: Archer A 3 arrows, Archer B 1 target
• Even volley: roles reversed
• Target 7-10 → ×2 on base score
• 1-6 or M → no effect
        ''';
      case GameType.solo:
        return '''
• Individual competition – 3 arrows per volley
• Values 1-10 or M (0) – cumulative score
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