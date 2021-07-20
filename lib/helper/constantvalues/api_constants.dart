
class UrlConstants{
  static const String _baseUrl = 'https://predictfox.com/trumpcard/api/';
  static const String _baseUrlImage = 'https://predictfox.com/trumpcard/';

  static const String login = "${_baseUrl}userlogin/login";
  static const String leaderboard = "${_baseUrl}fetch_details/fetch_leaderboard";
  static const String gameCategory = "${_baseUrl}fetch_details/fetch_cat";
  static const String statistic= "${_baseUrl}fetch_details/fetch_statistic";
  static const String game_friends= "${_baseUrl}fetch_details/fetch_friend_list";
  static const String cards= "${_baseUrl}fetch_details/fetch_cards";
  static const String profile = "${_baseUrl}fetch_details/fetch_profile";
  static const String matchMaking = "${_baseUrl}match_making/play";
  static const String saveMatch = "${_baseUrl}save_details/save_match";
  static const String cms_game_data = "${_baseUrl}fetch_details/fetch_cms";
  static const String notification_on_off = "${_baseUrl}/push_notification/on_off_notify";
  static const String send_notification_to_friend_for_battle = "${_baseUrl}/push_notification/push_notify";
}