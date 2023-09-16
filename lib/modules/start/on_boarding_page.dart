import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/components/classes/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OnBoardingCubit cubit = OnBoardingCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: () => cubit.skip(context),
                  child: const Text('Skip'),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: cubit.pageController,
                      itemBuilder: (context, index) => onBoardingItem(
                        model: cubit.boardingList[index],
                      ),
                      itemCount: cubit.boardingList.length,
                      onPageChanged: cubit.changeIndex,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SmoothPageIndicator(
                          controller: cubit.pageController,
                          count: cubit.boardingList.length,
                          effect: ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            activeDotColor: selectedColor(context),
                            spacing: 8,
                            expansionFactor: 4,
                            dotHeight: 10,
                            dotWidth: 15,
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () => cubit.nextPage(context),
                          disabledElevation: 2,
                          shape: const CircleBorder(),
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
