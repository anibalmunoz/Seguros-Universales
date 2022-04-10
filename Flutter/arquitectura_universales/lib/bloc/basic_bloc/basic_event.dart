part of 'basic_bloc.dart';

abstract class BasicEvent extends Equatable {}

class LoginButtonPressed extends BasicEvent {
  final nombre;
  LoginButtonPressed({required this.nombre});

  @override
  List<Object?> get props => [];
}

class CambiarModoPressed extends BasicEvent {
  bool modo;
  CambiarModoPressed({required this.modo});

  @override
  List<Object?> get props => [];
}
