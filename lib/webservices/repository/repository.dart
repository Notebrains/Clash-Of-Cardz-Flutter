

import 'package:trump_card_game/model/responses/weather_response_model.dart';

import '../api_provider/api_provider.dart';

class Repository {
  ApiProvider appApiProvider = ApiProvider();

  Future<WeatherResponse> fetchLondonWeather() => appApiProvider.fetchLondonWeather();
}
