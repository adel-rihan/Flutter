import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:news_api/shared/components/classes/components.dart';
import 'package:news_api/shared/cubit/cubit.dart';
import 'package:news_api/shared/cubit/states.dart';

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

          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: cubit.scaffoldKey,
              appBar: AppBar(
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      cubit.search(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(LineAwesomeIcons.moon),
                    onPressed: cubit.darkModeChange,
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: cubit.changeIndex,
                currentIndex: cubit.currentIndex,
                items: [
                  bottomNavItem(label: 'Business', icon: Icons.business),
                  bottomNavItem(label: 'Sports', icon: Icons.sports),
                  bottomNavItem(label: 'Science', icon: Icons.science),
                ],
              ),
              body: SafeArea(child: cubit.currentScreen()),
            ),
          );
        },
      ),
    );
  }
}
