part of 'basic_bloc.dart';

abstract class BasicEvent extends Equatable {}

class LoginButtonPressed extends BasicEvent {
  final nombre;
  LoginButtonPressed({required this.nombre});

  @override
  List<Object?> get props => [];
}
