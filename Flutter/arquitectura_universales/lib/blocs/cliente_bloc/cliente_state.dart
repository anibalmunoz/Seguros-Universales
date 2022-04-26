part of 'cliente_bloc.dart';

abstract class ClienteState extends Equatable {
  const ClienteState();

  @override
  List<Object> get props => [];
}

class ClienteInitial extends ClienteState {}

class IrADetallesPageState extends ClienteState {}

class IrACreacionState extends ClienteState {}

class GuardandoCliente extends ClienteState {}

class ClienteGuardado extends ClienteState {}

class EliminandoClienteState extends ClienteState {}

class ClienteEliminadoState extends ClienteState {}
