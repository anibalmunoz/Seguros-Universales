import 'package:arquitectura_universales/model/cliente_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  ClienteBloc() : super(ClienteInitial()) {
    on<DetallesButtonPressed>((event, emit) {
      emit(IrADetallesPageState());
    });

    on<CreacionClienteEvent>((event, emit) {
      emit(IrACreacionState());
    });

    on<ReturnListaPressed>((event, emit) {
      emit(ClienteInitial());
    });

    on<ModificarCliente>((event, emit) async {
      emit(GuardandoCliente());
      await Future.delayed(const Duration(seconds: 2), () {
        emit(ClienteGuardado());
      });
    });

    on<ClienteEliminadoEvent>((event, emit) {
      emit(ClienteEliminadoState());
    });
  }
}
