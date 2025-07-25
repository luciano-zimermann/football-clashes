import 'package:flutter/material.dart';

class ClashCard extends StatelessWidget {
  final String homeTeam;
  final int homeTeamTotalGoals;
  final String awayTeam;
  final int awayTeamTotalGoals;
  final String clashDate;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final int totalMatches;
  final String homeTeamOwner;
  final String awayTeamOwner;

  const ClashCard({
    Key? key,
    required this.homeTeam,
    required this.homeTeamTotalGoals,
    required this.awayTeam,
    required this.awayTeamTotalGoals,
    required this.clashDate,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.totalMatches,
    required this.homeTeamOwner,
    required this.awayTeamOwner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Image.network(
                        homeTeamLogo,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$homeTeam ($homeTeamOwner)',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  ' $homeTeamTotalGoals ' 'x' ' $awayTeamTotalGoals',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Image.network(
                        awayTeamLogo,
                        width: 50,
                        height: 50,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$awayTeam ($awayTeamOwner)',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data: $clashDate'),
                Text('Total de Partidas: $totalMatches'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
