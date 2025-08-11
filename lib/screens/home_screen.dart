import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arrowclash/bloc/auth_bloc.dart';
import 'package:arrowclash/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          title: Text(AppLocalizations.of(context)!.appName),
          actions: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final localizations = AppLocalizations.of(context)!;
                if (state is Authenticated) {
                  return PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        context.read<AuthBloc>().add(LogoutRequested());
                      } else if (value == 'stats') {
                        Navigator.of(context).pushNamed('/stats');
                      } else if (value == 'profile') {
                        Navigator.of(context).pushNamed('/profile');
                      } else if (value == 'settings') {
                        Navigator.of(context).pushNamed('/settings');
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          value: 'profile',
                          child: Text(localizations.profile),
                        ),
                        PopupMenuItem<String>(
                          value: 'stats',
                          child: Text(localizations.statistics),
                        ),
                        PopupMenuItem<String>(
                          value: 'settings',
                          child: Text(localizations.appSettings),
                        ),
                        PopupMenuItem<String>(
                          value: 'logout',
                          child: Text(localizations.logout),
                        ),
                      ];
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome message
                    Text(
                      AppLocalizations.of(context)!.welcome(state.name),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Game selection title
                    Text(
                      AppLocalizations.of(context)!.selectAGameMode,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Game mode cards
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildGameCard(
                            context,
                            title: 'Archery Duo Challenge',
                            description: AppLocalizations.of(context)!.gameTypeDuo,
                            icon: Icons.people,
                            color: Colors.blue,
                            gameType: 'duo',
                          ),
                          _buildGameCard(
                            context,
                            title: 'La Classica',
                            description: AppLocalizations.of(context)!.gameTypeClassica,
                            icon: Icons.sports,
                            color: Colors.green,
                            gameType: 'classica',
                          ),
                          _buildGameCard(
                            context,
                            title: 'Bull\'s Revenge',
                            description: AppLocalizations.of(context)!.gameTypeBull,
                            icon: Icons.track_changes,
                            color: Colors.red,
                            gameType: 'bull',
                          ),
                          _buildGameCard(
                            context,
                            title: 'Red Impact',
                            description: AppLocalizations.of(context)!.gameTypeImpact,
                            icon: Icons.center_focus_strong,
                            color: Colors.orange,
                            gameType: 'impact',
                          ),
                          _buildGameCard(
                            context,
                            title: '18m Singolo',
                            description: AppLocalizations.of(context)!.gameTypeSolo,
                            icon: Icons.person,
                            color: Colors.purple,
                            gameType: 'solo',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}