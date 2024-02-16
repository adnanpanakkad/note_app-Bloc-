
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({
    super.key,
    required this.id,
    required this.note,
  });

  final String id;
  final Map note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<HomeBloc>()
          .add(UpdateNavigationEvent(id: id, map: note)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      note['title'] ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ShowDialogEvent());
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              Flexible(
                  child: Text(
                note['description'] ?? '',
                overflow: TextOverflow.fade,
              )),
            ],
          ),
        ),
      ),
    );
  }
}


