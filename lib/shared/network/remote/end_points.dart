class EndPoints {
  /// User
  static const String login = 'login';
  static const String register = 'register';
  static const String logout = 'logout';
  static const String getProfile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String resetPassword = 'reset-password';
  static const String changePassword = 'change-password';

  /// Home
  static const String home = 'home';

  /// Categories
  static const String getCategories = 'categories';
  static String categoryDetails(int id) => 'categories/$id';

  /// Favorites
  static const String getFavorites = 'favorites';
  static const String changeFavorite = 'favorites';
  static const String deleteFavorites = 'favorites/1';

  /// Products
  static const String getProducts = 'products';
  static const String searchProducts = 'products/search';
}
