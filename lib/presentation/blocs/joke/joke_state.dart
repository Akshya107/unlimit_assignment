part of 'joke_bloc.dart';

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object> get props => [];
}

class JokeInitial extends JokeState {}

class JokeHasData extends JokeState {
  final String? result;
  final List<String>? localRes;

  const JokeHasData({this.result, this.localRes});
}

class JokeError extends JokeState {
  final String msg;

  const JokeError({required this.msg});

  @override
  List<Object> get props => [msg];
}
