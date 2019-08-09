import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/app_theme.dart';

@immutable
abstract class AppThemeEvent extends Equatable {
  AppThemeEvent([List props = const []]) : super(props);
}

class AppThemeChanged extends AppThemeEvent {
  final AppTheme theme;

  AppThemeChanged({
    @required this.theme,
  }) : super([theme]);
}
