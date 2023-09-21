import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks_local_database/modules/archived_tasks_screen.dart';
import 'package:tasks_local_database/modules/done_tasks_screen.dart';
import 'package:tasks_local_database/modules/new_tasks_screen.dart';
import 'package:tasks_local_database/shared/components/classes/components.dart';
import 'package:tasks_local_database/shared/components/classes/dialogs.dart';
import 'package:tasks_local_database/shared/cubit/states.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(InitialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  late Database db;
  bool isBottomSheetShown = false;
  bool newTask = true;
  late int taskID;
  IconData fabIcon = Icons.edit;

  List<Map> tasksNew = [];
  List<Map> tasksDone = [];
  List<Map> tasksArchive = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
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

  void changeIndex(index) {
    currentIndex = index;

    emit(ChangeHomeLayoutState());
  }

  void loadLayout(context) async {
    emit(LoadingHomeLayoutState());

    try {
      db = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (Database db, int version) async {
          try {
            await db
                .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)');
          } catch (error) {
            alertDialog(context, text: 'Error happened while creating the table!\n${error.toString()}');
          }
        },
        onOpen: (database) => getTasks(context, database: database),
      );
    } catch (error) {
      alertDialog(context, text: 'Error happened while opening the database!\n${error.toString()}');
    }
  }

  getTasks(context, {Database? database}) async {
    tasksNew = [];
    tasksDone = [];
    tasksArchive = [];

    if (database == null) emit(ChangeHomeLayoutState());

    database = database ?? db;

    try {
      List<Map> tasks = await database.rawQuery('SELECT * FROM tasks');

      var tasksSorted = tasks.map((element) {
        String finalDateAndTime = element['date'] + " " + element['time'];
        DateTime dateTime = DateFormat('MMM d, yyyy h:m a').parse(finalDateAndTime);

        final newElement = {
          ...element,
          'DateTime': dateTime.toString(),
        };

        return newElement;
      }).toList();

      tasksSorted.sort((a, b) => DateTime.parse(a["DateTime"]).compareTo(DateTime.parse(b["DateTime"])));

      tasksNew = tasksSorted.where((element) => element['status'] == 'New').toList();
      tasksDone = tasksSorted.where((element) => element['status'] == 'Done').toList();
      tasksArchive = tasksSorted.where((element) => element['status'] == 'Archive').toList();

      emit(ChangeHomeLayoutState());
    } catch (error) {
      alertDialog(context, text: 'Error happened while opening the database!\n${error.toString()}');
    }
  }

  Future floatingButton(context) async {
    if (isBottomSheetShown) {
      newTask ? insertTask(context) : updateTask(context);
    } else {
      showBottomSheet(context);
    }
  }

  showBottomSheet(context) {
    scaffoldKey.currentState!
        .showBottomSheet(
          elevation: 20.0,
          (context) => bottomSheet(
            newTask: newTask,
            formKey: formKey,
            titleController: titleController,
            timeController: timeController,
            dateController: dateController,
          ),
        )
        .closed
        .then((value) => bottomSheetStatus(false));

    bottomSheetStatus(true);
  }

  Future bottomSheetStatus(bool show) async {
    isBottomSheetShown = show;

    fabIcon = show ? Icons.add : Icons.edit;

    if (!show) {
      titleController.text = '';
      dateController.text = '';
      timeController.text = '';

      newTask = true;
    }

    emit(ChangeHomeLayoutState());
  }

  Future insertTask(context) async {
    if (formKey.currentState!.validate()) {
      try {
        await db.transaction((txn) async {
          await txn.rawInsert(
            'INSERT INTO tasks (title, date, time, status) VALUES(?, ?, ?, ?)',
            [titleController.text.trim(), dateController.text, timeController.text, 'New'],
          );
        });

        closeBottomSheet(context);
      } catch (error) {
        alertDialog(context, text: 'Error happened while getting the task!\n${error.toString()}');
      }
    }
  }

  updateTaskClicked(
    context, {
    required Map model,
  }) {
    titleController.text = model['title'];
    dateController.text = model['date'];
    timeController.text = model['time'];

    taskID = model['id'];
    newTask = false;

    showBottomSheet(context);
  }

  Future updateTask(context) async {
    try {
      await db.rawUpdate(
        'UPDATE tasks SET title = ?, date = ?, time = ? WHERE id = ?',
        [
          titleController.text.trim(),
          dateController.text,
          timeController.text,
          taskID,
        ],
      );

      closeBottomSheet(context);
    } catch (error) {
      alertDialog(context, text: 'Error happened while updating the task!\n${error.toString()}');
    }
  }

  closeBottomSheet(context) {
    Navigator.pop(context);

    bottomSheetStatus(false);

    getTasks(context);
  }

  Future updateStatus(
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

      await db.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', [statusStr, model['id']]);

      getTasks(context);
    } catch (error) {
      alertDialog(context, text: 'Error happened while updating the task!\n${error.toString()}');
    }
  }

  Future deleteTask(
    context, {
    required Map model,
  }) async {
    try {
      await db.rawUpdate('DELETE FROM tasks WHERE id = ?', [model['id']]);

      getTasks(context);
    } catch (error) {
      alertDialog(context, text: 'Error happened while deleting the task!\n${error.toString()}');
    }
  }
}
