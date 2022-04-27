import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'basic_state.dart';
part 'basic_event.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  BasicBloc() : super(AppStarted()) {
    on<LoginButtonPressed>((event, emit) {
      // BasicBloc basicBloc;
      // basicBloc = BlocProvider.of<BasicBloc>(context);

      // basicBloc.add(LogueadoEvent());
      emit(PageChanged(title: "Bienvenido " + event.nombre));
      emit(UsuarioLogueado());
    });

    on<DeslogueadoEvent>((event, emit) {
      emit(UsuarioDeslogueadoState(isLogueado: false));
    });

    on<LogueadoEvent>((event, emit) {
      emit(UsuarioDeslogueadoState(isLogueado: true));
    });

    on<Error403>((event, emit) {
      emit(UsuarioDeslogueadoState(isLogueado: false));
    });
  }
}
