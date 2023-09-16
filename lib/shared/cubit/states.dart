//
/// App
abstract class AppStates {}

class InitialAppState extends AppStates {}

class ChangeAppState extends AppStates {}

//
/// Splash Page
abstract class SplashStates {}

class InitialSplashState extends SplashStates {}

class LoadingSplashState extends SplashStates {}

class ChangeSplashState extends SplashStates {}

//
/// On Boarding Page
abstract class OnBoardingStates {}

class InitialOnBoardingState extends OnBoardingStates {}

class ChangeOnBoardingState extends OnBoardingStates {}

//
/// Login Page
abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class ChangeLoginState extends LoginStates {}

//
/// SignUp Page
abstract class SignUpStates {}

class InitialSignUpState extends SignUpStates {}

class ChangeSignUpState extends SignUpStates {}

//
/// Shop Layout
abstract class ShopStates {}

class InitialShopState extends ShopStates {}

class LoadingShopState extends ShopStates {}

class ChangeShopState extends ShopStates {}

//
/// Search Layout
abstract class SearchStates {}

class InitialSearchState extends SearchStates {}

class LoadingSearchState extends SearchStates {}

class ChangeSearchState extends SearchStates {}

//
/// Product Page
abstract class ProductStates {}

class InitialProductState extends ProductStates {}

class LoadingProductState extends ProductStates {}

class ChangeProductState extends ProductStates {}

//
/// Update Password Page
abstract class UpdatePasswordStates {}

class InitialUpdatePasswordState extends UpdatePasswordStates {}

class ChangeUpdatePasswordState extends UpdatePasswordStates {}

//
/// Update Profile Page
abstract class UpdateProfileStates {}

class InitialProfileUpdateState extends UpdateProfileStates {}

class ChangeProfileUpdateState extends UpdateProfileStates {}
