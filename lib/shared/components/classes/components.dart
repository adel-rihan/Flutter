import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

BottomNavigationBarItem bottomNavItem({
  required String label,
  required IconData icon,
}) =>
    BottomNavigationBarItem(
      label: label,
      icon: Icon(icon),
    );

Widget taskItem({
  required Map model,
  required void Function(BuildContext context) onNew,
  required void Function(BuildContext context) onDone,
  required void Function(BuildContext context) onArchive,
  required void Function(BuildContext context) onDelete,
}) =>
    Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        dragDismissible: false,
        extentRatio: 0.5,
        children: [
          Visibility(
            visible: model['status'] != 'New',
            child: SlidableAction(
              onPressed: onNew,
              backgroundColor: const Color(0xFFB08109),
              foregroundColor: Colors.white,
              icon: Icons.new_releases,
              label: 'New',
            ),
          ),
          Visibility(
            visible: model['status'] != 'Done',
            child: SlidableAction(
              onPressed: onDone,
              backgroundColor: const Color(0xFF619E2F),
              foregroundColor: Colors.white,
              icon: Icons.check_box,
              label: 'Done',
            ),
          ),
          Visibility(
            visible: model['status'] != 'Archive',
            child: SlidableAction(
              onPressed: onArchive,
              backgroundColor: const Color(0xFF757575),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        dragDismissible: false,
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: onDelete,
            backgroundColor: const Color(0xFFB02323),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 33,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  model['time'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    model['date'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 20),
            // Visibility(
            //   visible: model['status'] != 'New',
            //   child: IconButton(
            //     onPressed: onNew,
            //     icon: Icon(
            //       Icons.new_releases,
            //       color: Colors.yellow[700],
            //     ),
            //   ),
            // ),
            // Visibility(
            //   visible: model['status'] != 'Done',
            //   child: IconButton(
            //     onPressed: onDone,
            //     icon: const Icon(
            //       Icons.check_box,
            //       color: Colors.green,
            //     ),
            //   ),
            // ),
            // Visibility(
            //   visible: model['status'] != 'Archive',
            //   child: IconButton(
            //     onPressed: onArchive,
            //     icon: const Icon(
            //       Icons.archive,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );

Widget taskItemSeparator() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

Widget emptyTasks() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(Icons.menu),
          Text(
            'No tasks yet, please add some tasks.',
            style: TextStyle(color: Colors.grey[600]),
            // fontSize: 16, fontWeight: FontWeight.bold
          ),
        ],
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
  required Function(
    BuildContext context, {
    required int status,
    required Map model,
  }) update,
  required Function(
    BuildContext context, {
    required Map model,
  }) delete,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => taskItem(
                  model: tasks[index],
                  onNew: (_) {
                    update(context, status: 1, model: tasks[index]);
                  },
                  onDone: (_) {
                    update(context, status: 2, model: tasks[index]);
                  },
                  onArchive: (_) {
                    update(context, status: 3, model: tasks[index]);
                  },
                  onDelete: (_) {
                    delete(context, model: tasks[index]);
                  },
                ),
                separatorBuilder: (context, index) => taskItemSeparator(),
                itemCount: tasks.length,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      fallback: (context) => emptyTasks(),
    );
