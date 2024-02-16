part of 'home_bloc.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class SuccessState extends HomeState {
  List notesList = [];
  SuccessState({required this.notesList});
}

final class ErrorState extends HomeState {}

final class FormNavigationState extends HomeActionState {}

final class ShowPopupMessageState extends HomeActionState {}

final class DeleteNoteMessageState extends HomeActionState {}

final class UpdateNavigationState extends HomeActionState {
  final String id;
  final Map map;
  UpdateNavigationState({required this.id, required this.map});
}
