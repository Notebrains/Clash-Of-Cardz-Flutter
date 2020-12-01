import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/webservices/api_provider/api_provider.dart';


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

  Future<FriendsResModel> fetchFriends(String xApiKey) =>
      appApiProvider.friendsApi(xApiKey);

  Future<CardsResModel> fetchCardsApi(String xApiKey) =>
      appApiProvider.cardsApi(xApiKey);

  Future<ProfileResModel> fetchProfileApi(String xApiKey, String memberId) =>
      appApiProvider.profileApi(xApiKey, memberId);
}
