import 'dart:convert';
import 'package:clash_of_cardz_flutter/model/responses/NotificationOnOffResModel.dart';
import 'package:clash_of_cardz_flutter/model/responses/send_notification_to_friend_res_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:clash_of_cardz_flutter/helper/constantvalues/api_constants.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/friends_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/login_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/match_making_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/leaderboard_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/save_game_result_res_model.dart';

class ApiProvider {
  Client client = Client();

  Future<LoginResModel> loginApi(String name, String email, String socialId, String image, String deviceToken, String memberId) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': '56005600'};

    var requestBody = {
      'name': name,
      'social_id': socialId,
      'email': email,
      'image': image,
      'device_token': deviceToken,
      'memberid': memberId
    };

    http.Response response = await http.post(
      UrlConstants.login,
      headers: headers,
      body: requestBody,
    );

    print('----Login Res:  ${response.body.toString()}');

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

    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

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
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

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
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

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

  Future<CardsResModel> fetchCardsToPlayApi(
    String xApiKey,
    String catagory,
    String subCatagory,
    String subsubcatagory,
    String subsubsubcatagory,
    String cardCount,
    String gameId,
    String cardType,
  ) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

    var requestBody = {
      'catagory': catagory,
      'sub_catagory': subCatagory,
      'subsubcatagory': subsubcatagory,
      'subsubsubcatagory': subsubsubcatagory,
      'cardcount': cardCount,
      'game_id': gameId,
      'cardtype': cardType,
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

  Future<MatchMakingResModel> fetchMatchMakingApi(String xApiKey) async {}

  Future<MatchMakingResModel> fetchMatchReqToFriendApi(String xApiKey) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

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
      throw Exception('Failed to load Match Req To Friend response');
    }
  }

  Future<SaveGameResultResModel> fetchSaveGameResultApi(String xApiKey, List<Map<String, String>> matchDetails, String category) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

    var requestBody = {
      'match_result': json.encode(matchDetails),
      'category': category,
    };

    print('----- ${json.encode(requestBody)}');
    print('----- ${requestBody.toString()}');

    http.Response response = await http.post(
      UrlConstants.saveMatch,
      headers: headers,
      body: requestBody,
    );

    print('Save Game Result Res: ${response.body.toString()}');

    if (response.statusCode == 200) {
      return SaveGameResultResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Save Game Result response');
    }
  }

  Future<CmsResModel> fetchCmsApi(String xApiKey, String slug) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

    var requestBody = {
      'page_slug': slug,
    };

    http.Response response = await http.post(
      UrlConstants.cms_game_data,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return CmsResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load cms_game_data response');
    }
  }

  Future<NotificationsOnOffResModel> notificationOnOffApi(String xApiKey, String memberId, String onOffValue) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

    var requestBody = {
      'id': memberId,
      'value': onOffValue,
    };

    http.Response response = await http.post(
      UrlConstants.notification_on_off,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return NotificationsOnOffResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Notifications On Off response');
    }
  }

  Future<SendNotificationToFriendResModel> sendNotificationToFriendApi(String xApiKey, String title, String body,
      String receiverId, String gameCat1, String gameCat2, String gameCat3, String gameCat4, String gameType, String playerType, String cardsToPlay,
      String friendId, String friendName, String friendImage) async {
    Map<String, String> headers = {"Content-Type": 'application/x-www-form-urlencoded', 'x-api-key': xApiKey};

    var requestBody = {
      'title': title,
      'body': body,
      'reciver_id': receiverId, //id of friend
      'flag': '0',
      'gameCat1': gameCat1,
      'gameCat2': gameCat2,
      'gameCat3': gameCat3,
      'gameCat4': gameCat4,
      'gameType': gameType,
      'playerType': playerType,
      'cardsToPlay': cardsToPlay,
      'friendId': friendId, //who is sending match req
      'friendName': friendName,
      'friendImage': friendImage,
    };

    http.Response response = await http.post(
      UrlConstants.send_notification_to_friend_for_battle,
      headers: headers,
      body: requestBody,
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      return SendNotificationToFriendResModel.fromJson(json.decode(response.body)); //Return decoded response
    } else {
      throw Exception('Failed to load Notifications On Off response');
    }
  }
}
