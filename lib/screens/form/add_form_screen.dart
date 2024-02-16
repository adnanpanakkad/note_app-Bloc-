import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/add/add_bloc.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();
final formKey = GlobalKey<FormState>();

class ScreenAddForm extends StatelessWidget {
  const ScreenAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<AddBloc, AddState>(
        buildWhen: (previous, current) => current is! AddActionState,
        listenWhen: (previous, current) => current is AddActionState,
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.green,
                content: Text(
                  "Data Added Successfuly!!",
                  style: TextStyle(color: Colors.white),
                )));
            context.read<HomeBloc>().add(FetchSuccessEvent());
          } else if (state is AddNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(10),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.red,
                content: Text(
                  "Data Not Added !!",
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                        hintStyle: TextStyle(fontSize: 20)),
                    validator: (value) => titleController.text.isEmpty
                        ? 'Please enter a title'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                        hintStyle: TextStyle(fontSize: 20)),
                    validator: (value) => descriptionController.text.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        submitData(context);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(5),
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))))),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void submitData(BuildContext context) {
  final title = titleController.text;
  final description = descriptionController.text;
  final map = {
    "title": title,
    "description": description,
    "is_completed": false
  };
  context.read<AddBloc>().add(AddNoteEvent(map: map));
  titleController.text = '';
  descriptionController.text = '';
}
