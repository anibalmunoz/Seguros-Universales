part of 'basic_bloc.dart';

abstract class BasicEvent extends Equatable {}

class ButtonPressed extends BasicEvent {
  @override
  List<Object?> get props => [];
}
