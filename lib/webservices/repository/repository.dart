import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/cms_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/match_making_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/webservices/api_provider/api_provider.dart';
import 'package:trump_card_game/model/responses/save_game_result_res_model.dart';


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

  Future<CardsResModel> fetchCardsToPlayApi(String xApiKey, String subCatagory, String catagory, String playerCount, String cardCount) =>
      appApiProvider.fetchCardsToPlayApi(xApiKey, subCatagory, catagory, playerCount, cardCount);

  Future<MatchMakingResModel> fetchMatchMakingApi(String xApiKey) =>
      appApiProvider.fetchMatchMakingApi(xApiKey);

  Future<MatchMakingResModel> fetchMatchReqToFriendApi(String xApiKey) =>
      appApiProvider.fetchMatchReqToFriendApi(xApiKey);

  Future<SaveGameResultResModel> fetchSaveGameResultApi(String xApiKey, Map<String, Object> requestBody) =>
      appApiProvider.fetchSaveGameResultApi(xApiKey, requestBody);

  Future<CmsResModel> fetchCmsApi(String xApiKey, String slug,) =>
      appApiProvider.fetchCmsApi(xApiKey, slug);
}
