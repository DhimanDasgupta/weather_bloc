import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  WeatherEvent([List properties = const []]) : super(properties);
}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  GetWeatherEvent(this.cityName) : super([cityName]);
}
