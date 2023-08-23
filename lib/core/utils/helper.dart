import 'dart:math';

final List<String> laughingEmojis = ["😂", "🤣", "😆", "😄", "😅", "😁"];

String getRandomLaughingEmoji() {
  final randomIndex = Random().nextInt(laughingEmojis.length);
  return laughingEmojis[randomIndex];
}
