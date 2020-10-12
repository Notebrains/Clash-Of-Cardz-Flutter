import 'package:rxdart/rxdart.dart';
import 'package:trump_card_game/model/responses/weather_response_model.dart';
import 'package:trump_card_game/webservices/repository/repository.dart';


class WeatherBloc {
  Repository _repository = Repository();

  //Create a PublicSubject object responsible to add the data which is got from
  // the server in the form of WeatherResponse object and pass it to the UI screen as a stream.
  final _weatherFetcher = PublishSubject<WeatherResponse>();

  //This method is used to pass the weather response as stream to UI
  Stream<WeatherResponse> get weather => _weatherFetcher.stream;

  fetchLondonWeather() async {
    WeatherResponse weatherResponse = await _repository.fetchLondonWeather();
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose() {
    //Close the weather fetcher
    _weatherFetcher.close();
  }
}

final weatherBloc = WeatherBloc();
