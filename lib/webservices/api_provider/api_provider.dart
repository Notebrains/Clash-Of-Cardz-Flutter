import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:trump_card_game/helper/constantvalues/api_constants.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/match_making_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';


class ApiProvider {
  Client client = Client();

  Future<LoginResModel> loginApi(String name, String email, String socialId, String image, String deviceToken, String memberId) async {
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
    ); // Make the network call asynchronously to fetch data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return LoginResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Login response');
    }
  }

  Future<GameOptionResModel> gameOptApi(String xApiKey) async {
    final response = await client.get(
      UrlConstants.gameCategory,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key': xApiKey,
      },
    ); // Make the network call asynchronously to fetch the data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return GameOptionResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Game category response');
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
      return LeaderboardResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load leaderboard response');
    }
  }

  Future<StatisticsResModel> statisticsApi(String xApiKey, String memberId) async {
    //print("----" + xApiKey);
    //print("----" + memberId);

    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'x-api-key': xApiKey};

    var requestBody = {
      'memberid': memberId,
    };

    http.Response response = await http.post(
      UrlConstants.statistic,
      headers: headers,
      body: requestBody,
    );

    //print("Statistics Res: ---- " + response.body);

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return StatisticsResModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Statistics');
    }
  }

  Future<FriendsResModel> friendsApi(String xApiKey, String playerId) async {
    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'x-api-key': xApiKey};

    var requestBody = {
      'player_id': playerId,
    };

    http.Response response = await http.post(
      UrlConstants.game_friends,
      headers: headers,
      body: requestBody,
    );

    print(response.body.toString());

    if (response.statusCode == 200) {
      return FriendsResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load game friends response');
    }
  }

  Future<CardsResModel> cardsApi(String xApiKey) async {
    final response = await client.post(
      UrlConstants.cards,
      headers: <String, String>{
        "Content-Type": 'application/x-www-form-urlencoded',
        'x-api-key': xApiKey,
      },
    ); // Make the network call asynchronously to fetch the data.

    print(response.body.toString());

    if (response.statusCode == 200) {
      return CardsResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load player card response');
    }
  }

  Future<ProfileResModel> profileApi(String xApiKey, String memberId) async {
    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'x-api-key': xApiKey};

    var requestBody = {
      'member_id': memberId,
    };

    http.Response response = await http.post(
      UrlConstants.profile,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return ProfileResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load player profile response');
    }
  }

  Future<CardsResModel> fetchCardsToPlayApi(String xApiKey, String subCatagory, String catagory, String playerCount, String cardCount) async {
    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'x-api-key': xApiKey};

    var requestBody = {
      'sub_catagory': subCatagory,
      'catagory': catagory,
      'player_count': playerCount,
      'cardcount': cardCount,
    };

    http.Response response = await http.post(
      UrlConstants.cardsToPlay,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return CardsResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load player profile response');
    }
  }

Future<MatchMakingResModel> fetchMatchMakingApi(String xApiKey) async {
    Map<String, String> headers = {
      "Content-Type": 'application/x-www-form-urlencoded',
      'x-api-key': xApiKey};

    var requestBody = {
      '': '',
    };

    http.Response response = await http.post(
      UrlConstants.matchMaking,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return MatchMakingResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load player profile response');
    }
  }
}
