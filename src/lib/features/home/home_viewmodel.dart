import 'package:dory/app/app.bottomsheets.dart';
import 'package:dory/app/app.dialogs.dart';
import 'package:dory/app/app.locator.dart';
import 'package:dory/models/todo.dart';
import 'package:dory/services/todo_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _todoService = locator<TodoService>();

  List<Todo> get todos => _todoService.getAllTodos();

  void addTodo() async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Add New Todo',
      description: 'Enter todo details',
    );

    if (response != null && response.confirmed) {
      final data = response.data as Map<String, String>;
      _todoService.addTodo(data['title']!, data['description']!);
      rebuildUi();
    }
  }

  void toggleTodoCompletion(String id) {
    _todoService.toggleTodoCompletion(id);
    rebuildUi();
  }

  void deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      rebuildUi();
    }
  }

  void editTodo(Todo todo) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Edit Todo',
      description: 'Update todo details',
      data: {
        'title': todo.title,
        'description': todo.description,
      },
    );

    if (response != null && response.confirmed) {
      final data = response.data as Map<String, String>;
      final updatedTodo = todo.copyWith(
        title: data['title'],
        description: data['description'],
      );
      _todoService.updateTodo(updatedTodo);
      rebuildUi();
    }
  }

  // Keep existing counter functionality
  String get counterLabel => 'Counter is: $_counter';
  int _counter = 0;
  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Steve Rocks!',
      description: 'Give steve $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'title',
      description: 'desc',
    );
  }
}
