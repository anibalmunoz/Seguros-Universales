import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("EVENTO $event");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("ERROR $error");
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("BLOC: $bloc, CAMBIO: $change");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("BLOC  $bloc, TRANSICION: $transition");
  }
}
