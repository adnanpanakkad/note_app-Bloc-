part of 'home_bloc.dart';

abstract class HomeEvent {}

abstract class HomeActionEvent extends HomeEvent {}

final class FetchSuccessEvent extends HomeEvent {}

final class FormNavigationEvent extends HomeActionEvent {}

final class DeleteNoteEvent extends HomeActionEvent {
  final String id;
  DeleteNoteEvent({required this.id});
}

final class ShowDialogEvent extends HomeActionEvent {}

final class UpdateNavigationEvent extends HomeActionEvent {
  final String id;
  final Map map;
  UpdateNavigationEvent({required this.id, required this.map});
}
