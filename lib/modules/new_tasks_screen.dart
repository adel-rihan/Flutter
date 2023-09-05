import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_local_database/shared/components/classes/components.dart';
import 'package:tasks_local_database/shared/cubit/cubit.dart';
import 'package:tasks_local_database/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return tasksBuilder(
          tasks: cubit.tasksNew,
          update: cubit.updateDatabase,
          delete: cubit.deleteFromDatabase,
        );
      },
    );
  }
}
