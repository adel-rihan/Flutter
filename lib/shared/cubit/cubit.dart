import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_local_database/modules/archived_tasks_screen.dart';
import 'package:tasks_local_database/modules/done_tasks_screen.dart';
import 'package:tasks_local_database/modules/new_tasks_screen.dart';
import 'package:tasks_local_database/shared/components/classes/dialogs.dart';
import 'package:tasks_local_database/shared/cubit/states.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(InitialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  late Database db;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  late List<Map> tasksNew = [];
  late List<Map> tasksDone = [];
  late List<Map> tasksArchive = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final List<String> titles = const [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  final List screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  currentScreen() => screens[currentIndex];

  void loadLayout(context) async {
    emit(LoadingHomeLayoutState());

    try {
      db = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db
              .execute(
                  'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
              .onError((error, stackTrace) => alertDialog(context,
                  text:
                      'Error happened while creating the table!\n${error.toString()}'));
        },
        onOpen: (database) => getDatabase(context, database),
      );
    } catch (error) {
      alertDialog(context,
          text:
              'Error happened while opening the database!\n${error.toString()}');
    }
  }

  getDatabase(context, Database database) async {
    try {
      List<Map> tasks = await database.rawQuery('SELECT * FROM tasks');

      var tasksSorted = tasks.map((element) {
        String finalDateAndTime = element['date'] + " " + element['time'];
        final format = DateFormat('MMM d, yyyy h:m a');
        DateTime dateTime = format.parse(finalDateAndTime);

        final newElement = {
          ...element,
          'DateTime': dateTime.toString(),
        };
        return newElement;
      }).toList();

      tasksSorted.sort((a, b) => DateTime.parse(a["DateTime"])
          .compareTo(DateTime.parse(b["DateTime"])));

      tasksNew =
          tasksSorted.where((element) => element['status'] == 'New').toList();
      tasksDone =
          tasksSorted.where((element) => element['status'] == 'Done').toList();
      tasksArchive = tasksSorted
          .where((element) => element['status'] == 'Archive')
          .toList();

      emit(ChangeHomeLayoutState());
    } catch (error) {
      print(error);
      alertDialog(context,
          text:
              'Error happened while opening the database!\n${error.toString()}');
    }
  }

  void changeIndex(index) {
    currentIndex = index;

    emit(ChangeHomeLayoutState());
  }

  Future insertToDatabase(context) async {
    if (formKey.currentState!.validate()) {
      try {
        await db.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES(?, ?, ?, ?)',
              [
                titleController.text.trim(),
                dateController.text,
                timeController.text,
                'New'
              ]);
        });

        Navigator.pop(context);

        isBottomSheetShown = false;

        fabIcon = Icons.edit;

        getDatabase(context, db);
      } catch (error) {
        alertDialog(context,
            text:
                'Error happened while getting the task!\n${error.toString()}');
      }
    }
  }

  Future updateDatabase(
    context, {
    required int status,
    required Map model,
  }) async {
    try {
      String statusStr = status == 1
          ? 'New'
          : status == 2
              ? 'Done'
              : 'Archive';

      await db.rawUpdate(
          'UPDATE tasks SET status = ? WHERE id = ?', [statusStr, model['id']]);

      getDatabase(context, db);
    } catch (error) {
      alertDialog(context,
          text: 'Error happened while updating the task!\n${error.toString()}');
    }
  }

  Future deleteFromDatabase(
    context, {
    required Map model,
  }) async {
    try {
      await db.rawUpdate('DELETE FROM tasks WHERE id = ?', [model['id']]);

      getDatabase(context, db);
    } catch (error) {
      alertDialog(context,
          text: 'Error happened while deleting the task!\n${error.toString()}');
    }
  }

  Future bottomSheet(bool show) async {
    isBottomSheetShown = show;

    fabIcon = show ? Icons.add : Icons.edit;

    emit(ChangeHomeLayoutState());
  }
}
