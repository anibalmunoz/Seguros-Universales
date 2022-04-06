import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'basic_state.dart';
part 'basic_event.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  BasicBloc() : super(AppStarted()) {
    on<ButtonPressed>((event, emit) {
      emit(PageChanged(title: "Hola mundo"));
    });
  }
}
