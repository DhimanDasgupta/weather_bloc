import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class AppThemeState extends Equatable {
  final ThemeData themeData;

  AppThemeState({
    @required this.themeData,
  }) : super([themeData]);
}
