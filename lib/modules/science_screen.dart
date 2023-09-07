import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:news_api/shared/components/classes/components.dart';
import 'package:news_api/shared/cubit/cubit.dart';
import 'package:news_api/shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return LiquidPullToRefresh(
          animSpeedFactor: 4,
          springAnimationDurationInMilliseconds: 500,
          // backgroundColor: Theme.of(context).colorScheme.primary,
          // color: Colors.transparent,
          onRefresh: cubit.getScience,
          child: articlesBuilder(
            state: state,
            articles: cubit.scienceArticles,
          ),
        );
      },
    );
  }
}
