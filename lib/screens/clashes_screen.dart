import 'package:flutter/material.dart';
import 'package:football_clashes/cards/clash_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClashesScreen extends StatefulWidget {
  const ClashesScreen({super.key});

  @override
  ClashesScreenState createState() => ClashesScreenState();
}

class ClashesScreenState extends State<ClashesScreen> {
  void _addTestData() async {
    try {
      await FirebaseFirestore.instance.collection('test').add({
        'name': 'John',
        'age': 25,
        'active': true,
        'dt_creation': DateTime.timestamp(),
      });

      debugPrint('Dado de teste enviado com sucesso.');
    } catch (e) {
      debugPrint('Erro ao enviar dado de teste: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confrontos Futebolísticos')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ClashCard(
              homeTeam: 'Grêmio',
              homeTeamTotalGoals: 5,
              awayTeam: 'Internacional',
              awayTeamTotalGoals: 0,
              clashDate: '22/04/2024',
              homeTeamLogo:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Gremio_logo.svg/1718px-Gremio_logo.svg.png',
              awayTeamLogo:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Escudo_do_Sport_Club_Internacional.svg/480px-Escudo_do_Sport_Club_Internacional.svg.png',
              totalMatches: 2,
              homeTeamOwner: 'LZ',
              awayTeamOwner: 'FH',
            ),
            const ClashCard(
              homeTeam: 'França',
              homeTeamTotalGoals: 2,
              awayTeam: 'Inglaterra',
              awayTeamTotalGoals: 2,
              clashDate: '20/04/2024',
              homeTeamLogo:
                  'https://www.countryflags.com/wp-content/uploads/france-flag-png-xl.png',
              awayTeamLogo:
                  'https://www.countryflags.com/wp-content/uploads/england-flag-jpg-xl.jpg',
              totalMatches: 2,
              homeTeamOwner: 'LZ',
              awayTeamOwner: 'GSZ',
            ),
            ElevatedButton(
              onPressed: _addTestData,
              child: const Text('Teste Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
