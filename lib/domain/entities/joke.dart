import 'package:equatable/equatable.dart';

class Joke extends Equatable {
  final String text;

  const Joke({required this.text});

  @override
  List<Object?> get props => [text];
}
