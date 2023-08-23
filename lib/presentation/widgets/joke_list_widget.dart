import 'package:flutter/material.dart';
import 'package:unlimit_assignment/core/utils/helper.dart';

class JokeListWidget extends StatelessWidget {
  final List<String> jokes;

  const JokeListWidget({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(jokes[index]),
              trailing: Text(getRandomLaughingEmoji()),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: jokes.length);
  }
}
