part of 'edit_bloc.dart';

abstract class EditEvent {}

final class EditNoteEvent extends EditEvent {
  final String id;
  final Map map;
  EditNoteEvent({required this.id, required this.map});
}
