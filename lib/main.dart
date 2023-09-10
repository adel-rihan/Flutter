import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/layouts/home_layout.dart';
import 'package:bmi_calculator/modules/result_page.dart';
import 'package:bmi_calculator/shared/components/routes.dart';
import 'package:bmi_calculator/shared/cubit/bloc_observer.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:bmi_calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'BMI Calculator',
            debugShowCheckedModeBanner: false,
            theme: darkTheme,
            initialRoute: Routes.home,
            routes: {
              Routes.home: (context) => const HomeLayout(),
              Routes.result: (context) => const ResultPage(),
            },
          );
        },
      ),
    );
  }
}
