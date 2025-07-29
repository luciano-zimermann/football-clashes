import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_clashes/models/team.dart';

class NewClashFormScreen extends StatefulWidget {
  const NewClashFormScreen({super.key});

  @override
  NewClashFormScreenState createState() => NewClashFormScreenState();
}

class NewClashFormScreenState extends State<NewClashFormScreen> {
  Future<List<Team>> fetchTeams() async {
    final snapshot = await FirebaseFirestore.instance.collection('teams').get();
    return snapshot.docs
        .map(
          (doc) => Team(id: doc.id, name: doc['name'], logoUrl: doc['logoUrl']),
        )
        .toList();
  }

  List<Team> teams = [];
  Team? selectedHomeTeam;
  Team? selectedAwayTeam;

  bool isHomeTeamCustom = false;
  bool isAwayTeamCustom = false;

  final homeTeamNameController = TextEditingController();
  final homeTeamLogoController = TextEditingController();

  final awayTeamNameController = TextEditingController();
  final awayTeamLogoController = TextEditingController();

  final homeGoalsController = TextEditingController();
  final awayGoalsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTeams().then((list) {
      setState(() {
        teams = list;
      });
    });
  }

  void _saveClash() async {
    String homeName;
    String homeLogo;
    String awayName;
    String awayLogo;

    if (isHomeTeamCustom) {
      homeName = homeTeamNameController.text.trim();
      homeLogo = homeTeamLogoController.text.trim();
      await _addTeamIfNotExists(homeName, homeLogo);
    } else {
      homeName = selectedHomeTeam!.name;
      homeLogo = selectedHomeTeam!.logoUrl ?? '';
    }

    if (isAwayTeamCustom) {
      awayName = awayTeamNameController.text.trim();
      awayLogo = awayTeamLogoController.text.trim();
      await _addTeamIfNotExists(awayName, awayLogo);
    } else {
      awayName = selectedAwayTeam!.name;
      awayLogo = selectedAwayTeam!.logoUrl ?? '';
    }

    int homeGoals = int.tryParse(homeGoalsController.text) ?? 0;
    int awayGoals = int.tryParse(awayGoalsController.text) ?? 0;

    final clashRef = await FirebaseFirestore.instance
        .collection('clashes')
        .add({
          'homeTeamName': homeName,
          'homeTeamLogo': homeLogo,
          'awayTeamName': awayName,
          'awayTeamLogo': awayLogo,
          'homeTeamTotalGoals': homeGoals,
          'awayTeamTotalGoals': awayGoals,
          'clashDate': Timestamp.now(),
          'status': 'open',
        });

    await clashRef.collection('matches').add({
      'homeGoals': homeGoals,
      'awayGoals': awayGoals,
      'matchDate': Timestamp.now(),
    });

    Navigator.pop(context);
  }

  Future<void> _addTeamIfNotExists(String name, String logoUrl) async {
    final query = await FirebaseFirestore.instance
        .collection('teams')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('teams').add({
        'name': name,
        'logoUrl': logoUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Confronto')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Home Team selection or input
            DropdownButton<Team>(
              hint: Text('Selecionar Time Mandante'),
              value: isHomeTeamCustom ? null : selectedHomeTeam,
              items:
                  teams.map((team) {
                    return DropdownMenuItem<Team>(
                      value: team,
                      child: Text(team.name),
                    );
                  }).toList()..add(
                    DropdownMenuItem<Team>(
                      value: null,
                      child: Text('Outro (adicionar manualmente)'),
                    ),
                  ),
              onChanged: (team) {
                if (team == null) {
                  setState(() {
                    isHomeTeamCustom = true;
                    selectedHomeTeam = null;
                  });
                } else {
                  setState(() {
                    isHomeTeamCustom = false;
                    selectedHomeTeam = team;
                  });
                }
              },
            ),
            if (isHomeTeamCustom)
              Column(
                children: [
                  TextField(
                    controller: homeTeamNameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Time Mandante',
                    ),
                  ),
                  TextField(
                    controller: homeTeamLogoController,
                    decoration: InputDecoration(
                      labelText: 'Logo do Time Mandante (URL)',
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            DropdownButton<Team>(
              hint: Text('Selecionar Time Visitante'),
              value: isAwayTeamCustom ? null : selectedAwayTeam,
              items:
                  teams.map((team) {
                    return DropdownMenuItem<Team>(
                      value: team,
                      child: Text(team.name),
                    );
                  }).toList()..add(
                    DropdownMenuItem<Team>(
                      value: null,
                      child: Text('Outro (adicionar manualmente)'),
                    ),
                  ),
              onChanged: (team) {
                if (team == null) {
                  setState(() {
                    isAwayTeamCustom = true;
                    selectedAwayTeam = null;
                  });
                } else {
                  setState(() {
                    isAwayTeamCustom = false;
                    selectedAwayTeam = team;
                  });
                }
              },
            ),
            if (isAwayTeamCustom)
              Column(
                children: [
                  TextField(
                    controller: awayTeamNameController,
                    decoration: InputDecoration(
                      labelText: 'Nome do Time Visitante',
                    ),
                  ),
                  TextField(
                    controller: awayTeamLogoController,
                    decoration: InputDecoration(
                      labelText: 'Logo do Time Mandante (URL)',
                    ),
                  ),
                ],
              ),
            SizedBox(height: 20),
            TextField(
              controller: homeGoalsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gols - Mandante'),
            ),
            TextField(
              controller: awayGoalsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gols - Visitante'),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: _saveClash, child: Text('Salvar confronto')),
          ],
        ),
      ),
    );
  }
}
