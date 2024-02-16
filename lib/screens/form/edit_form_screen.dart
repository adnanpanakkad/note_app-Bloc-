import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/edit/edit_bloc.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';

final formKey = GlobalKey<FormState>();
final titleController = TextEditingController();
final descriptionController = TextEditingController();

class ScreenEdit extends StatefulWidget {
  const ScreenEdit({super.key, required this.id, required this.map});
  final String id;
  final Map map;

  @override
  State<ScreenEdit> createState() => _ScreenEditState();
}

class _ScreenEditState extends State<ScreenEdit> {
  @override
  void initState() {
    super.initState();
    final note = widget.map;
    titleController.text = note['title'];
    descriptionController.text = note['description'];
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text = '';
    descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Note"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocConsumer<EditBloc, EditState>(
          listener: (context, state) {
            if (state is EditSuccessState) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.green,
                  content: Text(
                    "Data updated Successfuly!!",
                    style: TextStyle(color: Colors.white),
                  )));
              context.read<HomeBloc>().add(FetchSuccessEvent());
            } else if (state is EditFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(10),
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Text(
                    "Data Not Updated !!",
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
                          update(context, widget.id);
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Update'),
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
        ));
  }

  void update(BuildContext context, String id) {
    final title = titleController.text;
    final description = descriptionController.text;

    final map = {
      'title': title,
      'description': description,
    };
    context.read<EditBloc>().add(EditNoteEvent(id: id, map: map));
  }
}
