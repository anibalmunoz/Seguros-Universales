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
}
