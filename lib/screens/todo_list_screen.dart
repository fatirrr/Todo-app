import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';
import 'todo_detail_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  List<Todo> filteredTodos = [];
  bool isLoading = true;
  String errorMessage = '';
  String searchQuery = '';
  String filterStatus = 'All'; // All, Completed, Pending

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final fetchedTodos = await ApiService.fetchTodos();
      setState(() {
        todos = fetchedTodos;
        filteredTodos = fetchedTodos;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void filterTodos() {
    List<Todo> filtered = todos;

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((todo) =>
              todo.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Filter by completion status
    if (filterStatus == 'Completed') {
      filtered = filtered.where((todo) => todo.completed).toList();
    } else if (filterStatus == 'Pending') {
      filtered = filtered.where((todo) => !todo.completed).toList();
    }

    setState(() {
      filteredTodos = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchTodos,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search todos...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchQuery = value;
                    filterTodos();
                  },
                ),
                const SizedBox(height: 10),
                // Filter Dropdown
                Row(
                  children: [
                    const Text('Filter: '),
                    DropdownButton<String>(
                      value: filterStatus,
                      items: ['All', 'Completed', 'Pending']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          filterStatus = value!;
                        });
                        filterTodos();
                      },
                    ),
                    const Spacer(),
                    Text(
                      'Total: ${filteredTodos.length}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Content Section
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error: $errorMessage',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: fetchTodos,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : filteredTodos.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No todos found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: fetchTodos,
                            child: ListView.builder(
                              itemCount: filteredTodos.length,
                              itemBuilder: (context, index) {
                                final todo = filteredTodos[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: todo.completed
                                          ? Colors.green
                                          : Colors.orange,
                                      child: Icon(
                                        todo.completed
                                            ? Icons.check
                                            : Icons.pending,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      todo.title,
                                      style: TextStyle(
                                        decoration: todo.completed
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        color: todo.completed
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'User ID: ${todo.userId} | ID: ${todo.id}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    trailing: Icon(
                                      todo.completed
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: todo.completed
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TodoDetailScreen(todo: todo),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}