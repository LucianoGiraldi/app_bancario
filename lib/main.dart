import 'package:flutter/material.dart';
import 'screens/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Transações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionList(), // Tela inicial do aplicativo
    );
  }
}
