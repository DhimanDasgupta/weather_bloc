import 'dart:math';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => WeatherInitialState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherEvent) {
      yield WeatherLoadingState(event.cityName);
      final weather = await _getFakeWeather(event.cityName);
      yield WeatherLoadedState(weather);
    } else {
      yield initialState;
    }
  }

  Future<Weather> _getFakeWeather(String cityName) {
    return Future.delayed(Duration(seconds: 3), () {
      return Weather(
          cityName: cityName,
          temperature: 10 + Random().nextInt(25) + Random().nextDouble());
    });
  }
}
