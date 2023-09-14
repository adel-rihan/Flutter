// import 'dart:io';
// import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/layouts/home_layout.dart';
import 'package:news_api/modules/search_page.dart';
import 'package:news_api/modules/webview_page.dart';
import 'package:news_api/network/local/cache_helper.dart';
import 'package:news_api/network/remote/dio_helper.dart';
import 'package:news_api/shared/components/classes/routes.dart';
import 'package:news_api/shared/cubit/bloc_observer.dart';
import 'package:news_api/shared/cubit/cubit.dart';
import 'package:news_api/shared/cubit/states.dart';
import 'package:news_api/styles/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = const AppBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  if (!await CacheHelper.checkKey('Dark Mode')) {
    CacheHelper.setBool('Dark Mode', false);
  }
  darkMode = await CacheHelper.getBool('Dark Mode');

  runApp(const MyApp());
}

late bool darkMode;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
            title: 'News API',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            // home: const HomeLayout(),
            initialRoute: Routes.home,
            routes: {
              Routes.home: (context) => const HomeLayout(),
              Routes.search: (context) => const SearchPage(),
              Routes.webview: (context) => const WebViewPage(),
            },
          );
        },
      ),
    );
  }
}
