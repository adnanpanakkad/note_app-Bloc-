part of 'add_bloc.dart';

abstract class AddEvent {}

final class AddNoteEvent extends AddEvent {
  final Map map;
  AddNoteEvent({required this.map});
}
