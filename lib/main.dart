import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlimit_assignment/presentation/blocs/joke/joke_bloc.dart';
import 'package:unlimit_assignment/presentation/pages/joke_page.dart';
import 'injection.dart' as dependency;

void main() {
  dependency.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<JokeBloc>(create: (_) => dependency.locator<JokeBloc>())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Unlimit',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const JokePage(),
        ));
  }
}
