import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebloc/screens/form/add/add_bloc.dart';
import 'package:notebloc/screens/form/edit/edit_bloc.dart';
import 'package:notebloc/screens/home/bloc/home_bloc.dart';
import 'package:notebloc/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => AddBloc(),
        ),
        BlocProvider(
          create: (context) => EditBloc(), 
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const ScreenHome(),
      ),
    );
  }
}