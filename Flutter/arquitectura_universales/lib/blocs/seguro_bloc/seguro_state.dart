part of 'seguro_bloc.dart';

abstract class SeguroState extends Equatable {
  const SeguroState();

  @override
  List<Object> get props => [];
}

class SeguroInitial extends SeguroState {}

class IrADetallesPageState extends SeguroState {}

class IrACreacionState extends SeguroState {}

class GuardandoSeguroState extends SeguroState {}

class SeguroGuardadoState extends SeguroState {}

class EliminandoSeguroState extends SeguroState {}

class SeguroEliminadoState extends SeguroState {}
