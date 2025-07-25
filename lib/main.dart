import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:football_clashes/firebase_options.dart';
import 'package:football_clashes/screens/clashes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FootballClashesApp());
}

class FootballClashesApp extends StatelessWidget {
  const FootballClashesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Confrontos',
      home: ClashesScreen(),
    );
  }
}