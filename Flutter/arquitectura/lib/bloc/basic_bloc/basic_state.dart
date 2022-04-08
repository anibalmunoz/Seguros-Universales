part of 'basic_bloc.dart';

abstract class BasicState {}

class AppStarted extends BasicState {}

class PageChanged extends BasicState {
  final title;

  PageChanged({required this.title});
}
