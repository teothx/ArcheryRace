import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String playerId;
  final String playerName;
  final int totalScore;
  final int gamesPlayed;
  final double averageScore;
  final DateTime lastGameDate;

  const LeaderboardEntry({
    required this.playerId,
    required this.playerName,
    required this.totalScore,
    required this.gamesPlayed,
    required this.averageScore,
    required this.lastGameDate,
  });

  @override
  List<Object> get props => [
        playerId,
        playerName,
        totalScore,
        gamesPlayed,
        averageScore,
        lastGameDate,
      ];

  Map<String, dynamic> toJson() => {
        'player_id': playerId,
        'player_name': playerName,
        'total_score': totalScore,
        'games_played': gamesPlayed,
        'average_score': averageScore,
        'last_game_date': lastGameDate.toIso8601String(),
      };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => LeaderboardEntry(
        playerId: json['player_id'] as String,
        playerName: json['player_name'] as String,
        totalScore: json['total_score'] as int,
        gamesPlayed: json['games_played'] as int,
        averageScore: (json['average_score'] as num).toDouble(),
        lastGameDate: DateTime.parse(json['last_game_date'] as String),
      );

  LeaderboardEntry copyWith({
    String? playerId,
    String? playerName,
    int? totalScore,
    int? gamesPlayed,
    double? averageScore,
    DateTime? lastGameDate,
  }) {
    return LeaderboardEntry(
      playerId: playerId ?? this.playerId,
      playerName: playerName ?? this.playerName,
      totalScore: totalScore ?? this.totalScore,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      averageScore: averageScore ?? this.averageScore,
      lastGameDate: lastGameDate ?? this.lastGameDate,
    );
  }
}

class Leaderboard extends Equatable {
  final List<LeaderboardEntry> entries;
  final DateTime lastUpdated;
  final bool isProvisional;

  const Leaderboard({
    required this.entries,
    required this.lastUpdated,
    this.isProvisional = false,
  });

  @override
  List<Object> get props => [entries, lastUpdated, isProvisional];

  Map<String, dynamic> toJson() => {
        'entries': entries.map((e) => e.toJson()).toList(),
        'last_updated': lastUpdated.toIso8601String(),
        'is_provisional': isProvisional,
      };

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        entries: (json['entries'] as List)
            .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
            .toList(),
        lastUpdated: DateTime.parse(json['last_updated'] as String),
        isProvisional: json['is_provisional'] as bool? ?? false,
      );

  Leaderboard copyWith({
    List<LeaderboardEntry>? entries,
    DateTime? lastUpdated,
    bool? isProvisional,
  }) {
    return Leaderboard(
      entries: entries ?? this.entries,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isProvisional: isProvisional ?? this.isProvisional,
    );
  }

  List<LeaderboardEntry> get sortedEntries {
    final sorted = List<LeaderboardEntry>.from(entries);
    sorted.sort((a, b) => b.totalScore.compareTo(a.totalScore));
    return sorted;
  }
}