part of 'siniestro_bloc.dart';

abstract class SiniestroState extends Equatable {
  const SiniestroState();

  @override
  List<Object> get props => [];
}

class SiniestroInitial extends SiniestroState {}

class IrADetallesPageState extends SiniestroState {}

class IrACreacionState extends SiniestroState {}

class GuardandoSiniestroState extends SiniestroState {}

class SiniestroGuardadoState extends SiniestroState {}

class EliminandoSiniestroState extends SiniestroState {}

class SiniestroEliminadoState extends SiniestroState {}
