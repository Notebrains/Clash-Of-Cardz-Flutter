import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/weather_response_model.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';

import '../api_provider/api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<WeatherResponse> fetchLondonWeather() => appApiProvider.fetchLondonWeather();

  Future<LoginResModel> fetchLoginApi(String name, String email, String socialId, String image, String deviceToken, String memberId) =>
      appApiProvider.loginApi(name, email, socialId, image, deviceToken, memberId);

  Future<LeaderboardResModel> fetchLeaderboardApi(String xApiKey) =>
      appApiProvider.leaderboardApi(xApiKey);

  Future<StatisticsResModel> fetchStatisticsApi(String xApiKey) =>
      appApiProvider.statisticsApi(xApiKey);
}
