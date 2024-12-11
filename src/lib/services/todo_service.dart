import 'package:dory/models/todo.dart';
import 'package:dory/repositories/todo_repository.dart';
import 'package:logger/logger.dart';

class TodoService {
  final TodoRepository _repository;
  final Logger _logger;

  TodoService({
    required TodoRepository repository,
    required Logger logger,
  })  : _repository = repository,
        _logger = logger;

  List<Todo> getAllTodos() {
    try {
      return _repository.getAllTodos();
    } catch (e) {
      _logger.e('Error getting todos: $e');
      return [];
    }
  }

  void addTodo(String title, String description) {
    try {
      final todo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      _repository.addTodo(todo);
      _logger.i('Added new todo: ${todo.title}');
    } catch (e) {
      _logger.e('Error adding todo: $e');
    }
  }

  void updateTodo(Todo todo) {
    try {
      _repository.updateTodo(todo);
      _logger.i('Updated todo: ${todo.title}');
    } catch (e) {
      _logger.e('Error updating todo: $e');
    }
  }

  void deleteTodo(String id) {
    try {
      _repository.deleteTodo(id);
      _logger.i('Deleted todo with id: $id');
    } catch (e) {
      _logger.e('Error deleting todo: $e');
    }
  }

  void toggleTodoCompletion(String id) {
    try {
      _repository.toggleTodoCompletion(id);
      _logger.i('Toggled completion for todo with id: $id');
    } catch (e) {
      _logger.e('Error toggling todo completion: $e');
    }
  }
}
