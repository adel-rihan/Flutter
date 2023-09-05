import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:tasks_local_database/shared/components/classes/auth_validator.dart';
import 'package:tasks_local_database/shared/components/classes/components.dart';
import 'package:tasks_local_database/shared/components/classes/formatters.dart';
import 'package:tasks_local_database/shared/components/controls/custom_date_field.dart';
import 'package:tasks_local_database/shared/components/controls/custom_input_field.dart';
import 'package:tasks_local_database/shared/components/controls/custom_time_field.dart';
import 'package:tasks_local_database/shared/cubit/cubit.dart';
import 'package:tasks_local_database/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit()..loadLayout(context),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

          return WillPopScope(
            onWillPop: () async => false,
            child: ConditionalBuilder(
              condition: state is! LoadingHomeLayoutState,
              builder: (context) => Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: cubit.changeIndex,
                  currentIndex: cubit.currentIndex,
                  selectedItemColor: Colors.black54,
                  unselectedItemColor: Colors.grey.withOpacity(0.5),
                  elevation: 15,
                  items: [
                    bottomNavItem(label: 'Tasks', icon: Icons.menu),
                    bottomNavItem(
                        label: 'Done', icon: Icons.check_circle_outline),
                    bottomNavItem(
                        label: 'Archived', icon: Icons.archive_outlined),
                  ],
                ),
                body: SafeArea(child: cubit.currentScreen()),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (cubit.isBottomSheetShown) {
                      cubit.insertToDatabase(context);
                    } else {
                      scaffoldKey.currentState!
                          .showBottomSheet(
                            elevation: 20.0,
                            (context) => Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: cubit.formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomInputField(
                                      controller: cubit.titleController,
                                      textType: TextInputType.text,
                                      validator: isFieldEmpty,
                                      labelText: 'Task Title',
                                      prefixIcon: Icons.title,
                                      inputFormatters: [nameFormatter],
                                    ),
                                    const SizedBox(height: 15.0),
                                    CustomTimeField(
                                      controller: cubit.timeController,
                                      labelText: 'Task Time',
                                      validator: isFieldEmpty,
                                      prefixIcon: Icons.av_timer_outlined,
                                    ),
                                    const SizedBox(height: 15.0),
                                    CustomDateField(
                                      controller: cubit.dateController,
                                      labelText: 'Task Date',
                                      validator: isFieldEmpty,
                                      prefixIcon: Icons.calendar_today_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .closed
                          .then((value) => cubit.bottomSheet(false));

                      cubit.bottomSheet(true);
                    }
                  },
                  child: Icon(cubit.fabIcon),
                ),
              ),
              fallback: (context) => const Scaffold(
                resizeToAvoidBottomInset: false,
                body: Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
}
