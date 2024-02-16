import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

Future<void> alertMessage(BuildContext context,String id) {
    return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete Note!!'),
                content: const Text(
                  'Are you sure, do you really want to delete this note!',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Discard'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Delete'),
                    onPressed: () => delete(context, id),
                  ),
                ],
              );
            },
          );
  }
  void delete(BuildContext context, String id) {
  context.read<HomeBloc>().add(DeleteNoteEvent(id: id));
  Navigator.of(context).pop();
  context.read<HomeBloc>().add(FetchSuccessEvent());
}