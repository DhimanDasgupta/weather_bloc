import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_bloc/model/Weather.dart';

@immutable
abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  WeatherLoadedState(this.weather) : super([weather]);
}
