import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<List<Todo>> fetchTodos() async {
    try {
      print('Fetching todos from: $baseUrl/todos');

      final response = await http.get(
        Uri.parse('$baseUrl/todos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        print('Successfully loaded ${jsonData.length} todos');
        return jsonData.map((json) => Todo.fromJson(json)).toList();
      } else {
        print('Error response body: ${response.body}');
        throw Exception('HTTP ${response.statusCode}: Failed to load todos');
      }
    } on TimeoutException {
      throw Exception(
          'Request timeout - Please check your internet connection');
    } on SocketException {
      throw Exception('No internet connection');
    } on FormatException {
      throw Exception('Invalid response format');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to fetch todos: $e');
    }
  }

  static Future<Todo> fetchTodoById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/todos/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Todo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch todo: $e');
    }
  }
}
