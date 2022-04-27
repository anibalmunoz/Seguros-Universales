part of 'basic_bloc.dart';

abstract class BasicState {
  bool isLogueado = false;

  bool get isAllGranted => isLogueado;

  // BasicState({
  //   this.isLogueado,
  // });

  cambiarlogueado() {
    this.isLogueado = !this.isLogueado;
  }
}

class AppStarted extends BasicState {}

class PageChanged extends BasicState {
  final title;

  PageChanged({required this.title});
}

class UsuarioLogueado extends BasicState {}

class UsuarioDeslogueadoState extends BasicState {
  final bool isLogueado;

  bool get isAllGranted => isLogueado;

  UsuarioDeslogueadoState({
    required this.isLogueado,
  });

  UsuarioDeslogueadoState copyWith({
    bool? isLogueado,
  }) =>
      UsuarioDeslogueadoState(
        isLogueado: isLogueado ?? this.isLogueado,
      );
}
