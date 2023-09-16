import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..loadLayout(context),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Salla'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: cubit.productsModel != null
                      ? () {
                          cubit.search(context);
                        }
                      : null,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) => cubit.changeIndex(context, value),
              currentIndex: cubit.currentIndex,
              items: [
                bottomNavItem(label: 'Home', icon: Icons.home),
                bottomNavItem(label: 'Categories', icon: Icons.apps),
                bottomNavItem(label: 'Favorites', icon: Icons.favorite),
                bottomNavItem(label: 'Settings', icon: Icons.settings),
              ],
            ),
            body: LiquidPullToRefresh(
              animSpeedFactor: 4,
              springAnimationDurationInMilliseconds: 500,
              onRefresh: () async => cubit.loadLayout(context),
              child: SafeArea(child: cubit.currentScreen()),
            ),
          );
        },
      ),
    );
  }
}
