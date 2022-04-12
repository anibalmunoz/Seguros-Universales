part of 'login_bloc_bloc.dart';

abstract class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class DoLoginEvent extends LoginBlocEvent {
  final String correo;
  final String password;

  DoLoginEvent(this.correo, this.password);

  @override
  List<Object> get props => [correo, password];
}
