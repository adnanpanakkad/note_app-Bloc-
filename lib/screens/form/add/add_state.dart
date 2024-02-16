part of 'add_bloc.dart';

abstract class AddState {}

abstract class AddActionState extends AddState {}

final class AddInitial extends AddState {}

final class AddNoteSuccessState extends AddActionState {}

final class AddNoteErrorState extends AddActionState {}
