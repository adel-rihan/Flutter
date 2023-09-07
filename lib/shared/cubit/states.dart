//
/// App
abstract class AppStates {}

class InitialAppState extends AppStates {}

class ChangeAppState extends AppStates {}

//
/// Home Layout
abstract class HomeLayoutStates {}

class InitialHomeLayoutState extends HomeLayoutStates {}

class LoadingHomeLayoutState extends HomeLayoutStates {}

class ChangeHomeLayoutState extends HomeLayoutStates {}

//
/// Search Page
abstract class SearchPageStates {}

class InitialSearchPageState extends SearchPageStates {}

class LoadingSearchPageState extends SearchPageStates {}

class ChangeSearchPageState extends SearchPageStates {}

//
/// WebView Page
abstract class WebViewPageStates {}

class InitialWebViewPageState extends WebViewPageStates {}

class ChangeWebViewPageState extends WebViewPageStates {}
