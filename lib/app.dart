import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/bloc/bloc.dart';
import 'package:weather_bloc/page/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => AppThemeBloc(),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: _buildWithTheme,
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, AppThemeState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: state.themeData,
      home: HomePage(),
    );
  }
}
