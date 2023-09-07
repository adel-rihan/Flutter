import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/modules/business_screen.dart';
import 'package:news_api/modules/science_screen.dart';
import 'package:news_api/modules/search_page.dart';
import 'package:news_api/modules/sports_screen.dart';
import 'package:news_api/network/local/cache_helper.dart';
import 'package:news_api/network/remote/dio_helper.dart';
import 'package:news_api/shared/cubit/states.dart';

//
/// App
class AppCubit extends Cubit<AppStates> {
  late bool darkMode;

  AppCubit(this.darkMode) : super(InitialAppState()) {
    appCubit = this;
  }

  static AppCubit get(context) => BlocProvider.of(context);

  void changeTheme() {
    CacheHelper.setBool('Dark Mode', !darkMode);

    darkMode = !darkMode;

    emit(ChangeAppState());
  }
}

AppCubit? appCubit;

//
/// Home Layout
class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(InitialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  List<dynamic> businessArticles = [];
  List<dynamic> sportsArticles = [];
  List<dynamic> scienceArticles = [];

  int currentIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final List<String> titles = const [
    'Business News',
    'Sports News',
    'Science News',
  ];

  final List screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  currentScreen() => screens[currentIndex];

  void changeIndex(index) {
    currentIndex = index;

    emit(ChangeHomeLayoutState());
  }

  void loadLayout(context) async {
    emit(LoadingHomeLayoutState());

    await getBusiness(refresh: false);
    await getSports(refresh: false);
    await getScience(refresh: false);

    emit(ChangeHomeLayoutState());
  }

  Future getBusiness({bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    businessArticles = [];

    await DioHelper.getData(
      query: {'category': 'business'},
    ).then((value) {
      businessArticles = value.data['articles'];
    }).catchError((error) {
      print(error);
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  Future getSports({bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    sportsArticles = [];

    await DioHelper.getData(
      query: {'category': 'sports'},
    ).then((value) {
      sportsArticles = value.data['articles'];
    }).catchError((error) {
      print(error);
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  Future getScience({bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    scienceArticles = [];

    await DioHelper.getData(
      query: {'category': 'science'},
    ).then((value) {
      scienceArticles = value.data['articles'];
    }).catchError((error) {
      print(error);
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  void search(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );

  void darkModeChange() {
    appCubit!.changeTheme();
  }
}

//
/// Search Page
class SearchPageCubit extends Cubit<SearchPageStates> {
  SearchPageCubit() : super(InitialSearchPageState());

  static SearchPageCubit get(context) => BlocProvider.of(context);

  TextEditingController searchInput = TextEditingController();

  List<dynamic> searchArticles = [];

  Future getSearch() async {
    emit(LoadingSearchPageState());

    searchArticles = [];

    await DioHelper.getData(
      query: {'q': searchInput.text.trim()},
      search: true,
    ).then((value) {
      searchArticles = value.data['articles'];
    }).catchError((error) {
      print(error);
    });

    emit(ChangeSearchPageState());
  }
}
