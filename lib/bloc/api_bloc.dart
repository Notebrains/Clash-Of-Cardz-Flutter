import 'package:rxdart/rxdart.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/match_making_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/webservices/repository/repository.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';
import 'package:trump_card_game/model/responses/save_game_result_res_model.dart';


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

  fetchCardsRes(String xApiKey, String subCatagory, String catagory, String playerCount, String cardCount) async {
    CardsResModel cardsResModel = await _repository.fetchCardsToPlayApi(xApiKey, subCatagory, catagory, playerCount, cardCount);
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

  fetchSaveGameResultRes(String xApiKey, Map<String, Object> requestBody) async {
    SaveGameResultResModel model = await _repository.fetchSaveGameResultApi(xApiKey, requestBody);
    _saveGameResultResFetcher.sink.add(model);
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
  }
}

final apiBloc = ApiBloc();
