import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'siniestro_event.dart';
part 'siniestro_state.dart';

class SiniestroBloc extends Bloc<SiniestroEvent, SiniestroState> {
  SiniestroBloc() : super(SiniestroInitial()) {
    on<DetallesButtonPressedEvent>((event, emit) {
      emit(IrADetallesPageState());
    });

    on<CreacionSiniestroEvent>((event, emit) {
      emit(IrACreacionState());
    });

    on<ReturnListaPressedEvent>((event, emit) {
      emit(SiniestroInitial());
    });

    on<ModificarSiniestroEvent>((event, emit) async {
      emit(GuardandoSiniestroState());
      await Future.delayed(const Duration(seconds: 2), () {
        emit(SiniestroGuardadoState());
      });
    });

    on<SiniestroEliminadoEvent>((event, emit) {
      emit(SiniestroEliminadoState());
    });
  }
}
