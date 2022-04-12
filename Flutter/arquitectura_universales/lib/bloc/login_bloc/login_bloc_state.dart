part of 'login_bloc_bloc.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();

  @override
  List<Object> get props => [];
}

//POSIBLES ESTADOS QUE SE VAN A MANEJAR EN EL LOGIN

class LoginBlocInitial extends LoginBlocState {}

class LogginInBlocState extends LoginBlocState {
  @override
  List<Object> get props => [];
}

class LoggedCorrectamenteBlocState extends LoginBlocState {
  final String token;

  LoggedCorrectamenteBlocState(this.token);

  @override
  List<Object> get props => [token];
}

class ErrorBlocState extends LoginBlocState {
  final String mensaje;
  ErrorBlocState(this.mensaje);
  @override
  List<Object> get props => [mensaje];
}
