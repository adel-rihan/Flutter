import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/start/splash_page.dart';
import 'package:shop/shared/cubit/bloc_observer.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  if (!await CacheHelper.check('Dark Mode')) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    darkMode = brightness == Brightness.dark;
    CacheHelper.set('Dark Mode', darkMode);
  } else {
    darkMode = await CacheHelper.get('Dark Mode');
  }

  if (!await CacheHelper.check('On Boarding')) CacheHelper.set('On Boarding', false);
  if (!await CacheHelper.check('Logged')) CacheHelper.set('Logged', false);

  runApp(const MyApp());
}

late bool darkMode;
late UserModel userModel;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Shop',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
