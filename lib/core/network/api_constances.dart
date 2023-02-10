class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "c3435cfe40aeb079689227d82bf921d3";
  static const String nowPlayingMoviesPath =
      "$baseUrl/movie/now_playing?api_key=$apiKey";
  static const String popularMoviesPath =
      "$baseUrl/movie/popular?api_key=$apiKey";
  static const String topRatedMoviesPath =
      "$baseUrl/movie/top_rated?api_key=$apiKey";

  static String movieDetailsPath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";

  static String recommendationsPath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';

  static const String onTheAirTvsPath =
      "$baseUrl/tv/on_the_air?api_key=$apiKey";
  static const String popularTvsPath = "$baseUrl/tv/popular?api_key=$apiKey";
  static const String topRatedTvsPath = "$baseUrl/tv/top_rated?api_key=$apiKey";

  static String tvDetailsPath(int tvId) => "$baseUrl/tv/$tvId?api_key=$apiKey";

  static String tvRecommendationsPath(int tvId) =>
      "$baseUrl/tv/$tvId/recommendations?api_key=$apiKey";

  static String tvSeasonPath(int tvId, int seasonNumber) =>
      "$baseUrl/tv/$tvId/season/$seasonNumber?api_key=$apiKey";
}
