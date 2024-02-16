import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:notebloc/api/api_functions.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddNoteEvent>(addNote);
  }

  FutureOr<void> addNote(AddNoteEvent event, Emitter<AddState> emit) async {
    final isSuccess = await Api.addNote(event.map);
    if (isSuccess) {
      emit(AddNoteSuccessState());
    } else {
      emit(AddNoteErrorState());
    }
  }
}
