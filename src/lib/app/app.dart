import 'package:dory/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:dory/ui/bottom_sheets/add_todo/add_todo_sheet.dart';
import 'package:dory/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:dory/ui/dialogs/todo_action/todo_action_dialog.dart';
import 'package:dory/features/home/home_view.dart';
import 'package:dory/features/startup/startup_view.dart';
import 'package:dory/services/todo_service.dart';
import 'package:dory/repositories/todo_repository.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:logger/logger.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: Logger),
    LazySingleton(classType: TodoRepository),
    LazySingleton(
      classType: TodoService,
      dependencies: [
        Dependency(classType: TodoRepository),
        Dependency(classType: Logger),
      ],
    ),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: AddTodoSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: TodoActionDialog),
  ],
)
class App {}
