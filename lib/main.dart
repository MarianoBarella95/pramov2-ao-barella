import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactoProvider(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login()
    );
  }
}
