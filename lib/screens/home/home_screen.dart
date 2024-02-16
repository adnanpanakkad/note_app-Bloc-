import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/add_form_screen.dart';
import 'package:notebloc/screens/form/edit_form_screen.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';
import 'package:notebloc/screens/home/widgets/functions.dart';
import 'package:notebloc/screens/home/widgets/note_card_widget.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchSuccessEvent());
  }

  late String id;
  late Map note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is! HomeActionState,
        listenWhen: (previous, current) => current is HomeActionState,
        listener: (context, state) {
          if (state is FormNavigationState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAddForm(),
                ));
          } else if (state is ShowPopupMessageState) {
            alertMessage(context,id);
          } else if (state is UpdateNavigationState) {
            Navigator.push( 
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScreenEdit(id: state.id, map: state.map),
                ));
          }
        },
        builder: (context, state) {
          if (state is SuccessState) {
            return GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(state.notesList.length, (index) {
                note = state.notesList[index] as Map;
                id = note['_id'];
                return NoteCardWidget(id: id, note: note);
              }),
            );
          } else if (state is LoadingState) {
            return const SizedBox.expand(
                child: Center(child: CircularProgressIndicator()));
          } else {
            return const SizedBox.expand(
              child: Center(child: Text('empty notes')),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeBloc>().add(FormNavigationEvent()),
        child: const Icon(Icons.add),
      ),
    );
  }

  
}
