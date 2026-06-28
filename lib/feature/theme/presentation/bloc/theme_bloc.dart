import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.system)) {
    on<ThemeInitialized>(_onInitialized);
    on<ThemeChanged>(_onChanged);
  }
  Future<void> _onInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }

  Future<void> _onChanged(ThemeChanged event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(themeMode: event.themeMode));
  }
}
