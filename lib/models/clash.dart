import 'package:cloud_firestore/cloud_firestore.dart';

class Clash {
  String id;
  String homeTeam;
  String awayTeam;
  String homeTeamLogo;
  String awayTeamLogo;
  String homeTeamOwner;
  String awayTeamOwner;
  String status;
  DateTime lastMatchDate;
  int totalMatches;
  int homeTeamTotalGoals;
  int awayTeamTotalGoals;

  Clash({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.homeTeamOwner,
    required this.awayTeamOwner,
    required this.status,
    required this.lastMatchDate,
    required this.totalMatches,
    required this.homeTeamTotalGoals,
    required this.awayTeamTotalGoals,
  });

  factory Clash.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Clash(
      id: doc.id,
      homeTeam: data['homeTeam'],
      awayTeam: data['awayTeam'],
      homeTeamLogo: data['homeTeamLogo'],
      awayTeamLogo: data['awayTeamLogo'],
      homeTeamOwner: data['homeTeamOwner'],
      awayTeamOwner: data['awayTeamOwner'],
      status: data['status'],
      lastMatchDate: (data['lastMatchDate'] as Timestamp).toDate(),
      totalMatches: data['totalMatches'],
      homeTeamTotalGoals: data['homeTeamTotalGoals'],
      awayTeamTotalGoals: data['awayTeamTotalGoals'],
    );
  }
}