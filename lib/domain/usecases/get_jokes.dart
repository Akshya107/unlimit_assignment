import 'package:dartz/dartz.dart';
import 'package:unlimit_assignment/data/failure.dart';
import 'package:unlimit_assignment/domain/entities/joke.dart';
import 'package:unlimit_assignment/domain/repositories/joke_repository.dart';

class GetNewJoke {
  final JokeRepository repository;

  const GetNewJoke({required this.repository});

  Future<Either<Failure, Joke>> execute() async {
    return repository.getJokes();
  }

  Future<Either<Failure, List<String>>> executeFromLocal() async {
    return repository.getFromLocal();
  }
}
