import 'package:equatable/equatable.dart';
import 'package:unlimit_assignment/domain/entities/joke.dart';

class JokeModel extends Equatable {
  final String joke;

  const JokeModel({
    required this.joke,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) => JokeModel(
        joke: json["joke"],
      );

  Map<String, dynamic> toJson() => {'joke': joke};

  Joke toEntity() => Joke(
        text: joke,
      );

  @override
  List<Object?> get props => [joke];
}
