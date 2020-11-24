import 'package:rxdart/rxdart.dart';
import 'package:trump_card_game/model/responses/cards_res_model.dart';
import 'package:trump_card_game/model/responses/friends_res_model.dart';
import 'package:trump_card_game/model/responses/login_res_model.dart';
import 'package:trump_card_game/model/responses/profile_res_model.dart';
import 'package:trump_card_game/model/responses/statistics_res_model.dart';
import 'package:trump_card_game/model/responses/weather_response_model.dart';
import 'package:trump_card_game/webservices/repository/repository.dart';
import 'package:trump_card_game/model/responses/leaderboard_res_model.dart';


class ApiBloc {
  Repository _repository = Repository();

  //Weather

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _weatherFetcher = PublishSubject<WeatherResponse>();

  //This method is used to pass the weather response as stream to UI
  Stream<WeatherResponse> get weather => _weatherFetcher.stream;

  fetchLondonWeather() async {
    WeatherResponse weatherResponse = await _repository.fetchLondonWeather();
    _weatherFetcher.sink.add(weatherResponse);
  }


  //Login
  final _loginResFetcher = PublishSubject<LoginResModel>();

  Stream<LoginResModel> get loginRes => _loginResFetcher.stream;

  fetchLoginRes(String name, String email, String socialId, String image, String deviceToken, String memberId) async {
    LoginResModel loginResponse = await _repository.fetchLoginApi(name, email, socialId, image, deviceToken, memberId);
    _loginResFetcher.sink.add(loginResponse);
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
    //Close the weather fetcher
    _weatherFetcher.close();
    _loginResFetcher.close();
    _leaderboardResFetcher.close();
    _statisticsResFetcher.close();
    _friendsResFetcher.close();
    _cardsResFetcher.close();
    _profileResFetcher.close();
  }
}

final apiBloc = ApiBloc();
