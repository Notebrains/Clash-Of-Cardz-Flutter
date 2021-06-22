import 'package:clash_of_cardz_flutter/model/responses/NotificationOnOffResModel.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/friends_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/login_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/match_making_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/send_notification_to_friend_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/leaderboard_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/webservices/api_provider/api_provider.dart';
import 'package:clash_of_cardz_flutter/model/responses/save_game_result_res_model.dart';


class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<LoginResModel> fetchLoginApi(String name, String email, String socialId, String image, String deviceToken, String memberId) =>
      appApiProvider.loginApi(name, email, socialId, image, deviceToken, memberId);

  Future<GameOptionResModel> fetchGameOptApi(String xApiKey) =>
      appApiProvider.gameOptApi(xApiKey);


  Future<LeaderboardResModel> fetchLeaderboardApi(String xApiKey) =>
      appApiProvider.leaderboardApi(xApiKey);

  Future<StatisticsResModel> fetchStatisticsApi(String xApiKey, String memberId) =>
      appApiProvider.statisticsApi(xApiKey, memberId);

  Future<FriendsResModel> fetchFriends(String xApiKey, String playerId) =>
      appApiProvider.friendsApi(xApiKey, playerId);


  Future<ProfileResModel> fetchProfileApi(String xApiKey, String memberId) =>
      appApiProvider.profileApi(xApiKey, memberId);

  Future<CardsResModel> fetchCardsToPlayApi(String xApiKey,
      String catagory,
      String subCatagory,
      String subsubcatagory,
      String subsubsubcatagory,
      String cardCount,
      String gameId,
      String cardType,) =>
      appApiProvider.fetchCardsToPlayApi(xApiKey, catagory, subCatagory, subsubcatagory, subsubsubcatagory, cardCount, gameId, cardType,);

  Future<MatchMakingResModel> fetchMatchMakingApi(String xApiKey) =>
      appApiProvider.fetchMatchMakingApi(xApiKey);

  Future<MatchMakingResModel> fetchMatchReqToFriendApi(String xApiKey) =>
      appApiProvider.fetchMatchReqToFriendApi(xApiKey);

  Future<SaveGameResultResModel> fetchSaveGameResultApi(String xApiKey,List<Map<String, String>> matchDetails, String category) =>
      appApiProvider.fetchSaveGameResultApi(xApiKey, matchDetails, category);

  Future<CmsResModel> fetchCmsApi(String xApiKey, String slug,) =>
      appApiProvider.fetchCmsApi(xApiKey, slug);

  Future<NotificationsOnOffResModel> notificationOnOffApi(String xApiKey, String memberId, String onOffValue) =>
      appApiProvider.notificationOnOffApi(xApiKey, memberId, onOffValue);

  Future<SendNotificationToFriendResModel> sendNotificationToFriendApi(String xApiKey, String title, String body,
      String receiverId, String gameCat1, String gameCat2, String gameCat3, String gameCat4, String gameType, String playerType, String cardsToPlay,
      String friendId, String friendName, String friendImage) =>
      appApiProvider.sendNotificationToFriendApi(xApiKey, title, body, receiverId, gameCat1, gameCat2, gameCat3, gameCat4, gameType,
          playerType, cardsToPlay, friendId, friendName, friendImage);
}
