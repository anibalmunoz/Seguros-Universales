import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seguro_event.dart';
part 'seguro_state.dart';

class SeguroBloc extends Bloc<SeguroEvent, SeguroState> {
  SeguroBloc() : super(SeguroInitial()) {
    on<DetallesButtonPressedEvent>((event, emit) {
      emit(IrADetallesPageState());
    });

    on<CreacionSeguroEvent>((event, emit) {
      emit(IrACreacionState());
    });

    on<ReturnListaPressedEvent>((event, emit) {
      emit(SeguroInitial());
    });

    on<ModificarSeguroEvent>((event, emit) async {
      emit(GuardandoSeguroState());
      await Future.delayed(const Duration(seconds: 2), () {
        emit(SeguroGuardadoState());
      });
    });

    on<SeguroEliminadoEvent>((event, emit) {
      emit(SeguroEliminadoState());
    });
  }
}
