import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:notebloc/api/api_functions.dart';


part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<EditNoteEvent>(editNoteEvent);
  }

 

  FutureOr<void> editNoteEvent(EditNoteEvent event, Emitter<EditState> emit) async{
  final isSuccess=await Api.updatNote(event.id, event.map);
  if (isSuccess) {
    emit(EditSuccessState());
  } else {
    emit(EditFailedState()); 
  }
  }
}