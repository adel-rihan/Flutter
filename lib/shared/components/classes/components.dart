import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasks_local_database/shared/components/classes/auth_validator.dart';
import 'package:tasks_local_database/shared/components/classes/formatters.dart';
import 'package:tasks_local_database/shared/components/controls/custom_date_field.dart';
import 'package:tasks_local_database/shared/components/controls/custom_input_field.dart';
import 'package:tasks_local_database/shared/components/controls/custom_time_field.dart';

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
  required void Function(BuildContext context) onUpdate,
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
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: onUpdate,
            backgroundColor: const Color(0xFF0B5878),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Update',
          ),
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
  }) updateStatus,
  required Function(
    BuildContext context, {
    required Map model,
  }) delete,
  required Function(
    BuildContext context, {
    required Map model,
  }) update,
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
                    updateStatus(context, status: 1, model: tasks[index]);
                  },
                  onDone: (_) {
                    updateStatus(context, status: 2, model: tasks[index]);
                  },
                  onArchive: (_) {
                    updateStatus(context, status: 3, model: tasks[index]);
                  },
                  onDelete: (_) {
                    delete(context, model: tasks[index]);
                  },
                  onUpdate: (_) {
                    update(context, model: tasks[index]);
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

Widget bottomSheet({
  required bool newTask,
  required GlobalKey<FormState> formKey,
  required TextEditingController titleController,
  required TextEditingController timeController,
  required TextEditingController dateController,
}) =>
    Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              newTask ? 'Add New Task' : 'Edit Task',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            CustomInputField(
              controller: titleController,
              textType: TextInputType.text,
              validator: isFieldEmpty,
              labelText: 'Task Title',
              prefixIcon: Icons.title,
              inputFormatters: [nameFormatter],
            ),
            const SizedBox(height: 15),
            CustomTimeField(
              controller: timeController,
              labelText: 'Task Time',
              validator: isFieldEmpty,
              prefixIcon: Icons.av_timer_outlined,
            ),
            const SizedBox(height: 15),
            CustomDateField(
              controller: dateController,
              labelText: 'Task Date',
              validator: isFieldEmpty,
              prefixIcon: Icons.calendar_today_outlined,
            ),
          ],
        ),
      ),
    );
