import 'package:app_flutter/Provider/ClienteProvider.dart';
import 'package:app_flutter/Screen/PageCliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ClienteProvider(),
      child: const MyApp(),
    ), 
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Clientes',
      theme: ThemeData(
       
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PageCliente(),
    );
  }
}
