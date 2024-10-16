import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'transaction_form.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TransactionApiService apiService = TransactionApiService();
  late Future<List<dynamic>> _transactions;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    setState(() {
      _transactions = apiService.getAll();
    });
  }

  void _createOrUpdateTransaction(Map<String, dynamic>? transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionForm(
          transaction: transaction,
          onSave: (data) async {
            if (transaction == null) {
              await apiService.create(data);
            } else {
              await apiService.update(transaction['id'], data);
            }
            _loadTransactions();
          },
        ),
      ),
    );
  }

  void _deleteTransaction(int id) async {
    await apiService.delete(id);
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Transações'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createOrUpdateTransaction(null),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma transação cadastrada'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var transaction = snapshot.data![index];
              return ListTile(
                title: Text(transaction['nome']),
                subtitle: Text('Valor: ${transaction['valor']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _createOrUpdateTransaction(transaction),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTransaction(transaction['id']),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
