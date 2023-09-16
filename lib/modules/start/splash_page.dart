import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..redirect(context),
      child: BlocConsumer<SplashCubit, SplashStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SplashCubit cubit = SplashCubit.get(context);

          return ConditionalBuilder(
            condition: state is LoadingSplashState,
            builder: (context) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            fallback: (context) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Check your internet connection,\nand Try again!',
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => cubit.redirect(context),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
