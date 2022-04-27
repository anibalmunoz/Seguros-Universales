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

class DeslogueadoEvent extends BasicEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LogueadoEvent extends BasicEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class Error403 extends BasicEvent {
  //Error403({});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
