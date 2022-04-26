part of 'siniestro_bloc.dart';

abstract class SiniestroEvent extends Equatable {
  const SiniestroEvent();

  @override
  List<Object> get props => [];
}

class DetallesButtonPressedEvent extends SiniestroEvent {}

class CreacionSiniestroEvent extends SiniestroEvent {}

class ReturnListaPressedEvent extends SiniestroEvent {}

class ModificarSiniestroEvent extends SiniestroEvent {}

class EliminandoSiniestroEvent extends SiniestroEvent {}

class SiniestroEliminadoEvent extends SiniestroEvent {}
