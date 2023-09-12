import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/modules/business_screen.dart';
import 'package:news_api/modules/science_screen.dart';
import 'package:news_api/modules/sports_screen.dart';
import 'package:news_api/network/local/cache_helper.dart';
import 'package:news_api/network/remote/dio_helper.dart';
import 'package:news_api/shared/components/classes/dialogs.dart';
import 'package:news_api/shared/components/classes/routes.dart';
import 'package:news_api/shared/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  bool sportsDone = false;
  bool scienceDone = false;

  int currentIndex = 0;

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

  void changeIndex(context, index) {
    currentIndex = index;

    emit(ChangeHomeLayoutState());

    if (index == 1 && !sportsDone) getSports(context);
    if (index == 2 && !scienceDone) getScience(context);
  }

  void loadLayout(context) async {
    emit(LoadingHomeLayoutState());

    await getBusiness(context, refresh: false);
    await getSports(context, refresh: false);
    await getScience(context, refresh: false);

    emit(ChangeHomeLayoutState());
  }

  Future getBusiness(context, {bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    businessArticles = [];

    await DioHelper.getData(
      query: {'category': 'business'},
    ).then((value) {
      businessArticles = value.data['articles'];
    }).catchError((error) {
      alertDialog(context, text: 'Error happened while getting the business news!\n${error.toString()}');
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  Future getSports(context, {bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    sportsDone = true;
    sportsArticles = [];

    await DioHelper.getData(
      query: {'category': 'sports'},
    ).then((value) {
      sportsArticles = value.data['articles'];
    }).catchError((error) {
      alertDialog(context, text: 'Error happened while getting the sports news!\n${error.toString()}');
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  Future getScience(context, {bool refresh = true}) async {
    if (refresh) emit(LoadingHomeLayoutState());

    scienceDone = true;
    scienceArticles = [];

    await DioHelper.getData(
      query: {'category': 'science'},
    ).then((value) {
      scienceArticles = value.data['articles'];
    }).catchError((error) {
      alertDialog(context, text: 'Error happened while getting the science news!\n${error.toString()}');
    });

    if (refresh) emit(ChangeHomeLayoutState());
  }

  void search(context) => Routes.pushSearch(context);

  void openUrl(context, Map args) async {
    if (kIsWeb) {
      final Uri url = Uri.parse(args['url']);
      var urllaunchable = await canLaunchUrl(url);
      if (urllaunchable) {
        await launchUrl(url);
      } else {
        alertDialog(context, text: 'URL can\'t be launched.\n$url');
      }
    } else {
      Routes.pushWebView(context, args);
    }
  }

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

  Future getSearch(context) async {
    emit(LoadingSearchPageState());

    searchArticles = [];

    await DioHelper.getData(
      query: {'q': searchInput.text.trim()},
      search: true,
    ).then((value) {
      searchArticles = value.data['articles'];
    }).catchError((error) {
      alertDialog(context, text: 'Error happened while getting the search news!\n${error.toString()}');
    });

    emit(ChangeSearchPageState());
  }

  void openUrl(context, Map args) async {
    if (kIsWeb) {
      final Uri url = Uri.parse(args['url']);
      var urllaunchable = await canLaunchUrl(url);
      if (urllaunchable) {
        await launchUrl(url);
      } else {
        alertDialog(context, text: 'URL can\'t be launched.\n$url');
      }
    } else {
      Routes.pushWebView(context, args);
    }
  }
}

//
/// WebView Page
class WebViewPageCubit extends Cubit<WebViewPageStates> {
  final Map args;

  WebViewPageCubit(this.args) : super(InitialWebViewPageState()) {
    url = args['url'];
    title = args['title'];
  }

  static WebViewPageCubit get(context) => BlocProvider.of(context);

  WebViewController webviewController = WebViewController();

  late String url;
  late String title;
  double progressValue = 0;

  void loadLayout(context) async {
    webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            progressValue = progress / 100;

            emit(ChangeWebViewPageState());
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}
