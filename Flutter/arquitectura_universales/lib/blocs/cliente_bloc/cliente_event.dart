part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

class DetallesButtonPressed extends ClienteEvent {}

class CreacionClienteEvent extends ClienteEvent {}

class ReturnListaPressed extends ClienteEvent {}

class ModificarCliente extends ClienteEvent {
  Cliente cliente;
  ModificarCliente({required this.cliente});
}

class EliminandoClienteEvent extends ClienteEvent {}

class ClienteEliminadoEvent extends ClienteEvent {}
