import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo todo;

  const TodoDetailScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      todo.completed ? Icons.check_circle : Icons.pending,
                      size: 48,
                      color: todo.completed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.completed ? 'Completed' : 'Pending',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: todo.completed ? Colors.green : Colors.orange,
                            ),
                          ),
                          Text(
                            'Status of this todo item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Title Section
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.title, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Details Section
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow(
                      icon: Icons.tag,
                      label: 'Todo ID',
                      value: todo.id.toString(),
                    ),
                    const Divider(),
                    _buildDetailRow(
                      icon: Icons.person,
                      label: 'User ID',
                      value: todo.userId.toString(),
                    ),
                    const Divider(),
                    _buildDetailRow(
                      icon: Icons.info,
                      label: 'Completed',
                      value: todo.completed ? 'Yes' : 'No',
                      valueColor: todo.completed ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        todo.completed
                            ? 'This todo is already completed!'
                            : 'Todo marked as completed! (Demo)',
                      ),
                      backgroundColor: todo.completed ? Colors.green : Colors.blue,
                    ),
                  );
                },
                icon: Icon(todo.completed ? Icons.check : Icons.check_circle),
                label: Text(todo.completed ? 'Already Completed' : 'Mark as Complete'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: todo.completed ? Colors.grey : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}