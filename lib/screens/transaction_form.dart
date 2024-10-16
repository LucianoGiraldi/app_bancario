import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final Map<String, dynamic>? transaction;
  final Function(Map<String, dynamic>) onSave;

  const TransactionForm({Key? key, this.transaction, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: transaction?['nome']);
    final TextEditingController valueController = TextEditingController(text: transaction?['valor']?.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(transaction == null ? 'Nova Transação' : 'Editar Transação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final transactionData = {
                  'nome': nameController.text,
                  'valor': double.tryParse(valueController.text) ?? 0.0,
                };
                onSave(transactionData);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
