import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/main.dart';
import 'package:shop/models/boarding_model.dart';
import 'package:shop/models/categories_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/layout/categories_screen.dart';
import 'package:shop/modules/layout/favorites_screen.dart';
import 'package:shop/modules/layout/home_screen.dart';
import 'package:shop/modules/layout/settings_screen.dart';
import 'package:shop/shared/components/classes/dialogs.dart';
import 'package:shop/shared/components/classes/loading_indicator_dialog.dart';
import 'package:shop/shared/components/classes/routes.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

//
/// App
class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState()) {
    appCubit = this;
  }

  static AppCubit get(context) => BlocProvider.of(context);

  void changeTheme() {
    CacheHelper.set('Dark Mode', !darkMode);

    darkMode = !darkMode;

    emit(ChangeAppState());
  }
}

late AppCubit appCubit;

//
/// Splash Page
class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(InitialSplashState());

  static SplashCubit get(context) => BlocProvider.of(context);

  void redirect(context) async {
    emit(LoadingSplashState());

    await Future.delayed(const Duration(seconds: 1));

    if (!await CacheHelper.get('On Boarding')) {
      Routes.pushOnBoarding(context);
    } else {
      if (await CacheHelper.get('Logged')) {
        DioHelper.get(
          url: EndPoints.getProfile,
          token: await CacheHelper.get('token'),
        ).then((value) {
          LoginModel loginModel = LoginModel.fromJson(value.data);

          if (loginModel.status) {
            userModel = loginModel.userModel!;

            Routes.pushShop(context);
          } else {
            CacheHelper.set('Logged', false);
            CacheHelper.set('token', '');

            Routes.pushLogin(context);
          }
        }).catchError((error) {});
      } else {
        Routes.pushLogin(context);
      }
    }
  }
}

//
/// On Boarding Page
class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(InitialOnBoardingState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController();

  final List<BoardingModel> boardingList = [
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Boarding 1 News',
      body: 'On Boarding 1 News Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Boarding 2 News',
      body: 'On Boarding 2 News Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Boarding 3 News',
      body: 'On Boarding 3 News Body',
    ),
  ];

  int currentIndex = 0;

  void changeIndex(index) => currentIndex = index;

  void nextPage(context) {
    if (currentIndex == boardingList.length - 1) {
      skip(context);
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.fastLinearToSlowEaseIn);
    }
  }

  void skip(context) {
    CacheHelper.set('On Boarding', true);

    Routes.pushLogin(context);
  }
}

//
/// Login Page
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final loginFormKey = GlobalKey<FormState>();

  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  void signUp(context) => Routes.pushSignUp(context);

  void login(context) async {
    if (loginFormKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      DioHelper.post(
        url: EndPoints.login,
        data: {
          'email': emailInput.text.trim(),
          'password': passwordInput.text,
        },
      ).then((value) {
        LoadingIndicatorDialog().dismiss();

        LoginModel loginModel = LoginModel.fromJson(value.data);

        if (loginModel.status) {
          userModel = loginModel.userModel!;

          CacheHelper.set('Logged', true);
          CacheHelper.set('token', userModel.token);

          Routes.pushShop(context);
        } else {
          alertDialog(context, text: loginModel.message);
        }
      }).catchError((error) {
        LoadingIndicatorDialog().dismiss();

        alertDialog(context, text: 'Check your internet connection!');
      });
    }
  }
}

//
/// SignUp Page
class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(InitialSignUpState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  final signupFormKey = GlobalKey<FormState>();

  TextEditingController nameInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  TextEditingController passwordRetryInput = TextEditingController();

  late String password = '';

  File? image;
  String base64Image = '';

  void refreshPassword(String pass) {
    password = pass;

    emit(ChangeSignUpState());
  }

  void selectPhoto(context) async {
    try {
      final imageX = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageX == null) return;
      image = File(imageX.path);

      List<int> imageBytes = image!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    } on PlatformException catch (error) {
      if (error.toString().toLowerCase().contains('user did not allow')) {
        alertDialog(context, text: 'Allow the app to access the gallery to change your profile picture.');
      } else {
        alertDialog(context, text: 'Failed to pick the image!');
      }
    }

    emit(ChangeSignUpState());
  }

  void signUp(context) {
    if (signupFormKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      final profileMap = {
        'name': nameInput.text.trim(),
        'email': emailInput.text.trim(),
        'phone': phoneInput.text.trim(),
        'password': passwordInput.text.trim(),
      };

      DioHelper.post(
        url: EndPoints.register,
        data: base64Image.isEmpty
            ? profileMap
            : {
                ...profileMap,
                'image': base64Image,
              },
      ).then((value) async {
        LoginModel loginModel = LoginModel.fromJson(value.data);

        if (loginModel.status) {
          DioHelper.get(
            url: EndPoints.getProfile,
            token: loginModel.userModel!.token,
          ).then((value) {
            LoadingIndicatorDialog().dismiss();

            loginModel = LoginModel.fromJson(value.data);

            if (loginModel.status) {
              userModel = loginModel.userModel!;

              CacheHelper.set('Logged', true);
              CacheHelper.set('token', userModel.token);
            }

            if (loginModel.status) {
              Navigator.pop(context);
              Routes.pushShop(context);
            } else {
              Navigator.pop(context);
            }

            alertDialog(context, text: 'Account Created Successfully!');
          }).catchError((error) {
            LoadingIndicatorDialog().dismiss();

            Navigator.pop(context);

            alertDialog(context, text: 'Account Created Successfully!');
          });
        } else {
          LoadingIndicatorDialog().dismiss();

          alertDialog(context, text: loginModel.message);
        }
      }).catchError((error) {
        LoadingIndicatorDialog().dismiss();

        alertDialog(context, text: 'Check your internet connection!');
      });
    }
  }
}

//
/// Shop Layout
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialShopState()) {
    shopCubit = this;
  }

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  bool favoritesLoading = false;
  bool productsLoading = false;
  bool homeLoading = false;
  bool categoriesLoading = false;

  FavoritesModel? favoritesModel;
  ProductsModel? productsModel;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;

  final List screens = const [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  currentScreen() => screens[currentIndex];

  void changeIndex(context, index) {
    currentIndex = index;

    emit(ChangeShopState());
  }

  void search(context) => Routes.pushSearch(context);

  Future loadLayout(context) async {
    if (!favoritesLoading && !productsLoading && !homeLoading && !categoriesLoading) {
      favoritesLoading = true;
      productsLoading = true;
      homeLoading = true;
      categoriesLoading = true;

      favoritesModel = null;
      productsModel = null;
      homeModel = null;
      categoriesModel = null;

      emit(ChangeShopState());

      getCategories(context);
      getFavorites(context).then((value) {
        getProducts(context).then((value) => getHome(context));
      });
    }
  }

  Future getFavorites(context) async => DioHelper.get(
        url: EndPoints.getFavorites,
        token: userModel.token,
      ).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);

        favoritesLoading = false;
      }).catchError((error) {
        favoritesLoading = false;
        alertDialog(context, text: 'Check your internet connection!');
      });

  Future getProducts(context) async => DioHelper.get(
        url: EndPoints.getProducts,
        token: userModel.token,
      ).then((value) {
        productsModel = ProductsModel.fromJson(value.data);

        if (productsModel!.status) {
          productsModel!.getFavorites(model: favoritesModel!);
        }
        emit(ChangeShopState());

        productsLoading = false;
      }).catchError((error) {
        productsLoading = false;
        alertDialog(context, text: 'Check your internet connection!');
      });

  Future getHome(context) async => DioHelper.get(
        url: EndPoints.home,
        token: userModel.token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data, productsList: productsModel!.products);
        emit(ChangeShopState());

        homeLoading = false;
      }).catchError((error) {
        homeLoading = false;
        alertDialog(context, text: 'Check your internet connection!');
      });

  Future getCategories(context) async => DioHelper.get(
        url: EndPoints.getCategories,
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ChangeShopState());

        categoriesLoading = false;
      }).catchError((error) {
        categoriesLoading = false;
        alertDialog(context, text: 'Check your internet connection!');
      });

  void setFavorite(context, {required ProductModel model}) async {
    bool inFav = model.inFavorites;
    setFavorite1(context, model: model, inFav: inFav);
    setFavorite2(context, model: model, inFav: inFav);
  }

  Future setFavorite1(context, {required ProductModel model, required bool inFav}) async {
    productsModel!.changeFavorite(favorite: !inFav, model: model);
    emit(ChangeShopState());
  }

  Future setFavorite2(context, {required ProductModel model, required bool inFav}) async => DioHelper.post(
        url: EndPoints.changeFavorite,
        token: userModel.token,
        data: {"product_id": model.id},
      ).then((value) {
        if (!value.data['status']) {
          productsModel!.changeFavorite(favorite: inFav, model: model);
          emit(ChangeShopState());
        }
      }).catchError((error) {
        productsModel!.changeFavorite(favorite: inFav, model: model);
        emit(ChangeShopState());
      });

  void openProduct(context, {required ProductModel model}) => Routes.pushProduct(context, model: model);

  void darkModeChange() {
    appCubit.changeTheme();

    emit(ChangeShopState());
  }

  void editProfile(context) => Routes.pushUpdateProfile(context);

  Future getProfile() async {
    DioHelper.get(
      url: EndPoints.getProfile,
      token: userModel.token,
    ).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);

      if (loginModel.status) userModel = loginModel.userModel!;

      emit(ChangeShopState());
    }).catchError((error) {});
  }

  void changePassword(context) => Routes.pushUpdatePassword(context);

  void signOut(context) async {
    if (await alertYesNoDialog(
      context,
      title: 'Logout',
      text: 'Are you sure, you want to Logout?',
    )) {
      CacheHelper.set('Logged', false);
      CacheHelper.set('token', '');

      Routes.pushLogin(context);

      DioHelper.post(
        url: EndPoints.logout,
        token: userModel.token,
      ).then((value) {}).catchError((error) {});
    }
  }
}

late ShopCubit shopCubit;

//
/// Search Page
class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  TextEditingController searchInput = TextEditingController();

  bool searching = false;
  SearchModel? searchModel;

  Future getSearch(context) async {
    searching = true;
    searchModel = null;
    emit(ChangeSearchState());

    DioHelper.post(
      url: EndPoints.searchProducts,
      token: userModel.token,
      data: {'text': searchInput.text.trim()},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data, productsList: shopCubit.productsModel!.products);

      searching = false;

      emit(ChangeSearchState());
    }).catchError((error) {
      searching = false;

      emit(ChangeSearchState());

      alertDialog(context, text: 'Check your internet connection!');
    });
  }

  void setFavorite(context, {required ProductModel model}) async {
    bool inFav = model.inFavorites;
    shopCubit.setFavorite1(context, model: model, inFav: inFav);
    emit(ChangeSearchState());
    shopCubit.setFavorite2(context, model: model, inFav: inFav).then((value) => emit(ChangeSearchState()));
  }

  void openProduct(context, {required ProductModel model}) => Routes.pushProduct(context, model: model);
}

//
/// Product Page
class ProductCubit extends Cubit<ProductStates> {
  final ProductModel model;

  ProductCubit({required this.model}) : super(InitialProductState());

  static ProductCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController();

  List<dynamic> imagesList = [];

  int currentIndex = 0;

  void changeIndex(index) => currentIndex = index;

  void loadyLayout() {
    if (model.image.isNotEmpty) imagesList.add(model.image);
    if (model.images.isNotEmpty) imagesList.addAll(model.images);
  }

  void setFavorite(context, {required ProductModel model}) async {
    bool inFav = model.inFavorites;
    shopCubit.setFavorite1(context, model: model, inFav: inFav);
    emit(ChangeProductState());
    shopCubit.setFavorite2(context, model: model, inFav: inFav).then((value) => emit(ChangeProductState()));
  }
}

//
/// Update Profile Page
class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(InitialProfileUpdateState()) {
    nameInput.text = userModel.name;
    emailInput.text = userModel.email;
    phoneInput.text = userModel.phone;
  }

  static UpdateProfileCubit get(context) => BlocProvider.of(context);

  final updateProfileFormKey = GlobalKey<FormState>();

  TextEditingController nameInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();

  File? image;
  String base64Image = '';

  void editPhoto(context) async {
    try {
      final imageX = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageX == null) return;
      image = File(imageX.path);

      List<int> imageBytes = image!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    } on PlatformException catch (error) {
      if (error.toString().toLowerCase().contains('user did not allow')) {
        alertDialog(context, text: 'Allow the app to access the gallery to change your profile picture.');
      } else {
        alertDialog(context, text: 'Failed to pick the image!');
      }
    }

    emit(ChangeProfileUpdateState());
  }

  void updateProfile(context) async {
    if (updateProfileFormKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      final profileMap = {
        'name': nameInput.text.trim(),
        'email': emailInput.text.trim(),
        'phone': phoneInput.text.trim(),
      };

      DioHelper.put(
        url: EndPoints.updateProfile,
        token: userModel.token,
        data: base64Image.isEmpty
            ? profileMap
            : {
                ...profileMap,
                'image': base64Image,
              },
      ).then((value) {
        LoadingIndicatorDialog().dismiss();

        if (!value.data['status']) {
          alertDialog(context, text: value.data['message']);
        } else {
          userModel.updateProfile(profileMap);

          Navigator.pop(context);

          shopCubit.emit(ChangeShopState());

          shopCubit.getProfile();

          alertDialog(context, text: 'Profile updated successfully!');
        }
      }).catchError((error) {
        LoadingIndicatorDialog().dismiss();

        alertDialog(context, text: 'Check your internet connection!');
      });
    }
  }
}

//
/// Update Password Page
class UpdatePasswordCubit extends Cubit<UpdatePasswordStates> {
  UpdatePasswordCubit() : super(InitialUpdatePasswordState());

  static UpdatePasswordCubit get(context) => BlocProvider.of(context);

  final updatePasswordFormKey = GlobalKey<FormState>();

  TextEditingController currentPasswordInput = TextEditingController();
  TextEditingController newPasswordInput = TextEditingController();
  TextEditingController passwordRetryInput = TextEditingController();

  late String password = '';

  void refreshPassword(String pass) {
    password = pass;

    emit(ChangeUpdatePasswordState());
  }

  void updatePassword(context) async {
    if (updatePasswordFormKey.currentState!.validate()) {
      LoadingIndicatorDialog().show(context);

      DioHelper.post(
        url: EndPoints.changePassword,
        token: userModel.token,
        data: {
          'current_password': currentPasswordInput.text.trim(),
          'new_password': newPasswordInput.text.trim(),
        },
      ).then((value) {
        LoadingIndicatorDialog().dismiss();

        if (!value.data['status']) {
          alertDialog(context, text: 'Your current password doesn\'t match our records.');
        } else {
          Navigator.pop(context);

          alertDialog(context, text: 'Password updated successfully!');
        }
      }).catchError((error) {
        LoadingIndicatorDialog().dismiss();

        alertDialog(context, text: 'Check your internet connection!');
      });
    }
  }
}
