import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../app_theme.dart';
import './bloc.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  @override
  AppThemeState get initialState => AppThemeState(themeData: appThemeData[AppTheme.BlueDark]);

  @override
  Stream<AppThemeState> mapEventToState(
    AppThemeEvent event,
  ) async* {
    if (event is AppThemeChanged) {
      yield AppThemeState(themeData: appThemeData[event.props]);
    }
  }
}
