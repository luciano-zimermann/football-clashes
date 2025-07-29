import 'package:cloud_firestore/cloud_firestore.dart';

class Match {
  String id;
  DateTime date;
  int homeTeamGoals;
  int awayTeamGoals;

  Match({
    required this.id,
    required this.date,
    required this.homeTeamGoals,
    required this.awayTeamGoals,
  });

  factory Match.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Match(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      homeTeamGoals: data['homeTeamGoals'],
      awayTeamGoals: data['awayTeamGoals'],
    );
  }
}