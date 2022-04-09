import 'package:arquitectura/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'basic_state.dart';
part 'basic_event.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  BasicBloc() : super(AppStarted()) {
    on<LoginButtonPressed>((event, emit) {
      emit(PageChanged(title: "Bienvenido " + event.nombre));
    });
  }

  // Future<bool> _checkModeStatus() async {
  //   final modoColor = await MyApp.themeNotifier;
  //   bool modoOscuro;

  //   if (modoColor == ThemeMode.light) {
  //     modoOscuro = false;
  //   } else {
  //     modoOscuro = true;
  //   }
  //   return modoColor;
  // }
}
