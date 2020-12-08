
class UrlConstants{
  static const String appName = 'CLASH OF CARDZ';
  static const String _baseUrl = 'https://predictfox.com/trumpcard/api/';
  static const String _baseUrlImage = 'https://predictfox.com/trumpcard/';

  //This is the London weather API url available at this link: https://openweathermap.org/current

  static const String baseUrlWeather =
      "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22";

  static const String login = "{_baseUrl}userlogin/login";
  static const String leaderboard = "${_baseUrl}fetch_details/fetch_leaderboard";
  static const String gameCategory = "${_baseUrl}fetch_details/fetch_cat";
  static const String statistic= "${_baseUrl}fetch_details/fetch_statistic";
  static const String game_friends= "${_baseUrl}fetch_details/fetch_friend_list";
  static const String cards= "${_baseUrl}fetch_details/fetch_cards";
  static const String profile = "${_baseUrl}fetch_details/fetch_profile";
  static const String cardsToPlay = "${_baseUrl}fetch_details/fetch_cards";
  static const String matchMaking = "${_baseUrl}match_making/play";

}