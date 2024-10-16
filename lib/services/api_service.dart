import 'dart:convert';
import 'package:http/http.dart' as http;



abstract class ApiService {
  Future<List<dynamic>> fetchTransactions();
  Future<void> addTransaction(Map<String, dynamic> transaction);
  Future<void> updateTransaction(String id, Map<String, dynamic> transaction);
  Future<void> deleteTransaction(String id);
}

class TransactionApiService implements ApiService {
  final String apiUrl = 'http://localhost:3000/transacoes';

  @override
  Future<List<dynamic>> fetchTransactions() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  @override
  Future<void> addTransaction(Map<String, dynamic> transaction) async {
    await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaction),
    );
  }

  @override
  Future<void> updateTransaction(String id, Map<String, dynamic> transaction) async {
    await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaction),
    );
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await http.delete(Uri.parse('$apiUrl/$id'));
  }

  // Métodos que você precisa implementar
  Future<List<dynamic>> getAll() async {
    return await fetchTransactions(); // Chama o método fetchTransactions
  }

  Future<void> create(Map<String, dynamic> transaction) async {
    await addTransaction(transaction); // Chama o método addTransaction
  }

  Future<void> update(String id, Map<String, dynamic> transaction) async {
    await updateTransaction(id, transaction); // Chama o método updateTransaction
  }

  Future<void> delete(int id) async {
    await deleteTransaction(id.toString()); // Chama o método deleteTransaction
  }
}
