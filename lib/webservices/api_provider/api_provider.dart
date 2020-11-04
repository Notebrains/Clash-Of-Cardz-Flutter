import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:trump_card_game/helper/constantvalues/api_constants.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/weather_response_model.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';


class ApiProvider {
  Client client = Client();

  Future<WeatherResponse> fetchLondonWeather() async {
    final response = await client.get(
        UrlConstants.baseUrlWeather); // Make the network call asynchronously to fetch the London weather data.
    print(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(
          json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<LoginResModel> loginApi(String name, String email, String socialId,
      String image, String deviceToken, String memberId) async {
    final response = await client.post(
      UrlConstants.login,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': '56005600',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'social_id': socialId,
        'email': email,
        'image': image,
        'device_token': deviceToken,
        'memberid': memberId,
      }),
    ); // Make the network call asynchronously to fetch the London weather data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return LoginResModel.fromJson(
          json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Login response');
    }
  }

  Future<LeaderboardResModel> leaderboardApi(String xApiKey) async {
    final response = await client.post(
      UrlConstants.leaderboard,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': xApiKey,
      },
    ); // Make the network call asynchronously to fetch the data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return LeaderboardResModel.fromJson(
          json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load leaderboard response');
    }
  }

  Future<StatisticsResModel> statisticsApi(String xApiKey) async {
    final response = await client.post(
      UrlConstants.statistic,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': xApiKey,
      },
    ); // Make the network call asynchronously to fetch the data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return StatisticsResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load leaderboard response');
    }
  }
}
