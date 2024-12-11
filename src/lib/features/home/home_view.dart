import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stacked/stacked.dart';
import 'package:dory/features/home/widgets/todo_list.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'My Todos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(20),
                  // Keep existing counter UI
                  MaterialButton(
                    color: Colors.black,
                    onPressed: viewModel.incrementCounter,
                    child: Text(
                      viewModel.counterLabel,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.grey,
                        onPressed: viewModel.showDialog,
                        child: const Text(
                          'Show Dialog',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      MaterialButton(
                        color: Colors.grey,
                        onPressed: viewModel.showBottomSheet,
                        child: const Text(
                          'Show Bottom Sheet',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TodoList(
                todos: viewModel.todos,
                onToggle: viewModel.toggleTodoCompletion,
                onDelete: viewModel.deleteTodo,
                onEdit: viewModel.editTodo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
