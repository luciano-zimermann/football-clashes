import 'package:flutter/material.dart';
import 'package:football_clashes/cards/clash_card.dart';
import 'package:football_clashes/screens/new_clash_form_screen.dart';

class ClashesScreen extends StatefulWidget {
  const ClashesScreen({super.key});

  @override
  ClashesScreenState createState() => ClashesScreenState();
}

class ClashesScreenState extends State<ClashesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewClashFormScreen()),
          );
        },
        child: Icon(Icons.add_road),
      ),
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
          ],
        ),
      ),
    );
  }
}
