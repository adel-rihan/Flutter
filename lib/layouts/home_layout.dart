import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:tasks_local_database/shared/components/classes/components.dart';
import 'package:tasks_local_database/shared/cubit/cubit.dart';
import 'package:tasks_local_database/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit()..loadLayout(context),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

          return ConditionalBuilder(
            condition: state is! LoadingHomeLayoutState,
            builder: (context) => Scaffold(
              key: cubit.scaffoldKey,
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
                  cubit.floatingButton(context);
                },
                child: Icon(cubit.fabIcon),
              ),
            ),
            fallback: (context) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
