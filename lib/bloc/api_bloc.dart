import 'package:rxdart/rxdart.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/game_option_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/webservices/repository/repository.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';


class ApiBloc {
  Repository _repository = Repository();

  //Login
  final _loginResFetcher = PublishSubject<LoginResModel>();

  Stream<LoginResModel> get loginRes => _loginResFetcher.stream;

  fetchLoginRes(String name, String email, String socialId, String image, String deviceToken, String memberId) async {
    LoginResModel loginResponse = await _repository.fetchLoginApi(name, email, socialId, image, deviceToken, memberId);
    _loginResFetcher.sink.add(loginResponse);
  }

  //Gage Option
  final _gameCatResFetcher = PublishSubject<GameOptionResModel>();

  Stream<GameOptionResModel> get gameCatRes => _gameCatResFetcher.stream;

  fetchGameOptionRes(String xApiKey) async {
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

  fetchFriendsRes(String xApiKey) async {
    FriendsResModel friendsResModel = await _repository.fetchFriends(xApiKey);
    _friendsResFetcher.sink.add(friendsResModel);
  }


  //cards
  final _cardsResFetcher = PublishSubject<CardsResModel>();
  Stream<CardsResModel> get cardsRes => _cardsResFetcher.stream;

  fetchCardsRes(String xApiKey) async {
    CardsResModel cardsResModel = await _repository.fetchCardsApi(xApiKey);
    _cardsResFetcher.sink.add(cardsResModel);
  }

  //profile
  final _profileResFetcher = PublishSubject<ProfileResModel>();
  Stream<ProfileResModel> get profileRes => _profileResFetcher.stream;

  fetchProfileRes(String xApiKey, String memberId) async {
    ProfileResModel profileResModel = await _repository.fetchProfileApi(xApiKey, memberId);
    _profileResFetcher.sink.add(profileResModel);
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
  }
}

final apiBloc = ApiBloc();
