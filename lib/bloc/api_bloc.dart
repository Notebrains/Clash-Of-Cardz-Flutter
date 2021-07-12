import 'package:clash_of_cardz_flutter/model/responses/NotificationOnOffResModel.dart';
import 'package:clash_of_cardz_flutter/model/responses/send_notification_to_friend_res_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:clash_of_cardz_flutter/model/responses/cards_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/cms_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/friends_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/game_option_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/login_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/match_making_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/profile_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/statistics_res_model.dart';
import 'package:clash_of_cardz_flutter/webservices/repository/repository.dart';
import 'package:clash_of_cardz_flutter/model/responses/leaderboard_res_model.dart';
import 'package:clash_of_cardz_flutter/model/responses/save_game_result_res_model.dart';


class ApiBloc {
  Repository _repository = Repository();

  //Login
  final _loginResFetcher = PublishSubject<LoginResModel>();

  Stream<LoginResModel> get loginRes => _loginResFetcher.stream;

  fetchLoginRes(String name, String email, String socialId, String image, String deviceToken, String memberId) async {
    LoginResModel loginResponse = await _repository.fetchLoginApi(name, email, socialId, image, deviceToken, memberId);
    _loginResFetcher.sink.add(loginResponse);
  }

  //Game Option
  final _gameCatResFetcher = PublishSubject<GameOptionResModel>();

  Stream<GameOptionResModel> get gameCatRes => _gameCatResFetcher.stream;

  fetchGameOptionRes(String xApiKey) async {
    print('----GameOption xApiKey: $xApiKey');
    GameOptionResModel model = await _repository.fetchGameOptApi(xApiKey);
    _gameCatResFetcher.sink.add(model);
  }


  //Leaderboard
  final _leaderboardResFetcher = PublishSubject<LeaderboardResModel>();

  Stream<LeaderboardResModel> get leaderboardRes => _leaderboardResFetcher.stream;

  fetchLeaderboardRes(String xApiKey) async {
    LeaderboardResModel leaderboardResModel = await _repository.fetchLeaderboardApi(xApiKey);
    _leaderboardResFetcher.sink.add(leaderboardResModel);
  }


  //statistics
  final _statisticsResFetcher = PublishSubject<StatisticsResModel>();

  Stream<StatisticsResModel> get statisticsRes => _statisticsResFetcher.stream;

  fetchStatisticsRes(String xApiKey, String memberId) async {
    StatisticsResModel statisticsResModel = await _repository.fetchStatisticsApi(xApiKey, memberId);
    _statisticsResFetcher.sink.add(statisticsResModel);
  }


  //friends
  final _friendsResFetcher = PublishSubject<FriendsResModel>();
  Stream<FriendsResModel> get friendsRes => _friendsResFetcher.stream;

  fetchFriendsRes(String xApiKey, String playerId) async {
    FriendsResModel friendsResModel = await _repository.fetchFriends(xApiKey, playerId);
    _friendsResFetcher.sink.add(friendsResModel);
  }


  //cards
  final _cardsResFetcher = PublishSubject<CardsResModel>();
  Stream<CardsResModel> get cardsRes => _cardsResFetcher.stream;

  fetchCardsRes(
      String xApiKey,
      String catagory,
      String subCatagory,
      String subsubcatagory,
      String subsubsubcatagory,
      String cardCount,
      String gameId,
      String cardType,) async {
    CardsResModel cardsResModel = await _repository.fetchCardsToPlayApi(xApiKey, catagory, subCatagory, subsubcatagory, subsubsubcatagory, cardCount, gameId, cardType,);
    _cardsResFetcher.sink.add(cardsResModel);
  }

  //profile
  final _profileResFetcher = PublishSubject<ProfileResModel>();
  Stream<ProfileResModel> get profileRes => _profileResFetcher.stream;

  fetchProfileRes(String xApiKey, String memberId) async {
    ProfileResModel profileResModel = await _repository.fetchProfileApi(xApiKey, memberId);
    _profileResFetcher.sink.add(profileResModel);
  }

  //match making
  final _matchMakingResFetcher = PublishSubject<MatchMakingResModel>();

  Stream<MatchMakingResModel> get matchMakingRes => _matchMakingResFetcher.stream;

  fetchMatchMakingRes(String xApiKey) async {
    MatchMakingResModel model = await _repository.fetchMatchMakingApi(xApiKey);
    _matchMakingResFetcher.sink.add(model);
  }


  //send notification request to friend by API
  final _matchReqToFriendFetcher = PublishSubject<MatchMakingResModel>();

  Stream<MatchMakingResModel> get matchReqToFriendRes => _matchReqToFriendFetcher.stream;

  fetchMatchReqToFriendRes(String xApiKey) async {
    MatchMakingResModel model = await _repository.fetchMatchReqToFriendApi(xApiKey);
    _matchReqToFriendFetcher.sink.add(model);
  }

  //save game result
  final _saveGameResultResFetcher = PublishSubject<SaveGameResultResModel>();

  Stream<SaveGameResultResModel> get saveGameResultRes => _saveGameResultResFetcher.stream;

  fetchSaveGameResultRes(String xApiKey, List<Map<String, String>> matchDetails, String category) async {
    SaveGameResultResModel model = await _repository.fetchSaveGameResultApi(xApiKey, matchDetails, category);
    _saveGameResultResFetcher.sink.add(model);
  }

  //cms page
  final _cmsFetcher = PublishSubject<CmsResModel>();
  Stream<CmsResModel> get cmsResModel => _cmsFetcher.stream;

  fetchCmsRes(String xApiKey, String slug) async {
    CmsResModel model = await _repository.fetchCmsApi(xApiKey, slug);
    _cmsFetcher.sink.add(model);
  }

  //Notification On Off page
  final _notificationOnOffFetcher = PublishSubject<NotificationsOnOffResModel>();
  Stream<NotificationsOnOffResModel> get notificationOnOffResModel => _notificationOnOffFetcher.stream;

  fetchNotificationsOnOffRes(String xApiKey, String memberId, String onOffValue) async {
    NotificationsOnOffResModel model = await _repository.notificationOnOffApi(xApiKey, memberId, onOffValue);
    _notificationOnOffFetcher.sink.add(model);
  }

  //Send Notification to friend for battle page
  final _sendNotificationToFriendFetcher = PublishSubject<SendNotificationToFriendResModel>();
  Stream<SendNotificationToFriendResModel> get sendNotificationToFriendResponseModel => _sendNotificationToFriendFetcher.stream;

  sendNotificationToFriendApi(String xApiKey, String title, String body,
      String receiverId, String gameCat1, String gameCat2, String gameCat3, String gameCat4, String gameType, String playerType, String cardsToPlay,
      String friendId, String friendName, String friendImage) async {
    SendNotificationToFriendResModel model = await _repository.sendNotificationToFriendApi(xApiKey, title, body,
        receiverId, gameCat1, gameCat2, gameCat3, gameCat4, gameType, playerType, cardsToPlay,
        friendId, friendName, friendImage);
    _sendNotificationToFriendFetcher.sink.add(model);
  }

  dispose() {
    //Close the api fetcher
    _loginResFetcher.close();
    _leaderboardResFetcher.close();
    _statisticsResFetcher.close();
    _friendsResFetcher.close();
    _cardsResFetcher.close();
    _profileResFetcher.close();
    _gameCatResFetcher.close();
    _matchMakingResFetcher.close();
    _matchReqToFriendFetcher.close();
    _saveGameResultResFetcher.close();
    _cmsFetcher.close();
    _notificationOnOffFetcher.close();
    _sendNotificationToFriendFetcher.close();

  }
}

final apiBloc = ApiBloc();
