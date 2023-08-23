import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlimit_assignment/presentation/blocs/joke/joke_bloc.dart';
import 'package:unlimit_assignment/presentation/widgets/joke_list_widget.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  List<String> jokes = [];

  @override
  void initState() {
    BlocProvider.of<JokeBloc>(context).add(FetchNewJokeEvent());
    Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      BlocProvider.of<JokeBloc>(context).add(FetchNewJokeEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
      ),
      body: BlocConsumer<JokeBloc, JokeState>(
        listener: (context, state) {
          if (state is JokeHasData) {
            if (state.localRes != null && state.localRes!.isNotEmpty) {
              jokes.addAll(state.localRes!.toList());
            } else {
              jokes.add(state.result!);
            }

            if (jokes.length > 10) {
              jokes.removeAt(0);
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<JokeBloc, JokeState>(
            builder: (context, state) {
              if (state is JokeHasData) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: JokeListWidget(jokes: jokes),
                );
              }
              if (state is JokeError) {
                return Center(
                  child: Text(state.msg),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
