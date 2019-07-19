import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc/bloc/weather_bloc.dart';
import 'package:weather_bloc/bloc/weather_event.dart';
import 'package:weather_bloc/bloc/weather_state.dart';
import 'package:weather_bloc/model/Weather.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('City Weather'),
      ),
      body: BlocProvider(
        builder: (context) => WeatherBloc(),
        child: WeatherPageChild(
          scaffoldKey: _scaffoldKey,
        ),
        dispose: true,
      ),
    );
  }
}

class WeatherPageChild extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const WeatherPageChild({Key key, this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 40.0,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: BlocListener(
              bloc: BlocProvider.of<WeatherBloc>(context),
              listener: (BuildContext context, WeatherState state) {
                var message = "";
                if (state is WeatherLoadedState) {
                  message = 'Retrived Weather for ${state.weather.cityName}';
                } else if (state is WeatherLoadingState) {
                  message = 'Loading Weather...';
                }

                if (message.length > 0) {
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text(message),
                  ));
                }
              },
              child: BlocBuilder(
                bloc: BlocProvider.of<WeatherBloc>(context),
                builder: (context, WeatherState state) {
                  if (state is WeatherLoadingState) {
                    return _buildLoading();
                  } else if (state is WeatherLoadedState) {
                    return _buildColumnWithData(state.weather);
                  }
                  return _buildInitialInput();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Builds widgets from the starter UI with custom weather data
  Widget _buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${weather.temperature.toStringAsFixed(2)} °C",
          style: TextStyle(fontSize: 80),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 0.0),
          child: CityInputField(),
        ),
      ],
    );
  }
}

class CityInputField extends StatefulWidget {
  const CityInputField({
    Key key,
  }) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.dispatch(GetWeatherEvent(cityName));
  }
}
