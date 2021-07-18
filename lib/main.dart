import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hero/src/app.dart';
import 'package:flutter_hero/src/bloc/app_bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
}

