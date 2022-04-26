part of 'seguro_bloc.dart';

abstract class SeguroEvent extends Equatable {
  const SeguroEvent();

  @override
  List<Object> get props => [];
}

class DetallesButtonPressedEvent extends SeguroEvent {}

class CreacionSeguroEvent extends SeguroEvent {}

class ReturnListaPressedEvent extends SeguroEvent {}

class ModificarSeguroEvent extends SeguroEvent {}

class EliminandoSeguroEvent extends SeguroEvent {}

class SeguroEliminadoEvent extends SeguroEvent {}
