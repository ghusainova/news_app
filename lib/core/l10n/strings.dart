class AppStrings {
  // App Title & Navigation
  static const String appTitle = 'News App';
  static const String newsTitle = 'News';
  static const String favoritesTitle = 'Favorites';
  static const String navNews = 'News';
  static const String navFavorites = 'Favorites';

  // News Page
  static const String searchNews = 'Search news';
  static const String selectCategory = 'Select category';
  static const String allCategories = 'All categories';
  static const String searchAction = 'Search';

  // Categories
  static const String general = 'General';
  static const String business = 'Business';
  static const String entertainment = 'Entertainment';
  static const String health = 'Health';
  static const String science = 'Science';
  static const String sports = 'Sports';
  static const String technology = 'Technology';

  // Favorites
  static const String addedToFavorites = 'Added to favorites';
  static const String removedFromFavorites = 'Removed from favorites';

  // Messages
  static const String noNewsAvailable = 'No news available yet.';
  static const String requestCancelled = 'Request cancelled.';
  static const String noSavedArticles = 'No saved articles yet.';
  static const String noDataAvailable = 'No data available.';
  static const String noInternetConnection = 'No internet connection.';
  static const String localStorageError = 'Local storage error.';
  static const String rateLimitExceeded = 'Rate limit exceeded. Please try again later.';
  static const String unknownErrorTryAgain = 'An unknown error occurred. Please try again.';
  static const String networkError = 'Network error. Please check your internet connection.';
  static const String unknownError = 'Unknown error. Please try again later.';
  static const String connectTimeout = 'Connection timed out. Please check your connection.';
  static const String sendTimeout = 'Request timed out while sending data. Please try again later.';
  static const String receiveTimeout = 'Request timed out while receiving data. Please try again later.';

  // HTTP errors
  static const String http400 = 'Bad request. Please check the input.';
  static const String http401 = 'Unauthorized. Please sign in.';
  static const String http403 = 'Access denied.';
  static const String http404 = 'Resource not found.';
  static const String http429 = 'Too many requests. Please try again later.';
  static const String http500 = 'Server error. Please try again later.';
  static const String http5xx = 'Server is temporarily unavailable. Please try again later.';
  static String httpUnknown(int? statusCode) =>
      'Server error ($statusCode). Please try again later.';

  // Detail page
  static const String newsDetailsTitle = 'News details';

  // UI actions / states
  static const String refresh = 'Refresh';
  static const String retry = 'Retry';
  static const String loadErrorTitle = 'Load error';

  // Fallbacks for missing article fields
  static const String untitledArticle = 'Untitled';
  static const String unknownSource = 'Unknown source';
}
