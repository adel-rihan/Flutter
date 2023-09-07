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
/// App
abstract class SearchPageStates {}

class InitialSearchPageState extends SearchPageStates {}

class LoadingSearchPageState extends SearchPageStates {}

class ChangeSearchPageState extends SearchPageStates {}
