import 'package:dartz/dartz.dart';
import 'package:unlimit_assignment/data/failure.dart';
import 'package:unlimit_assignment/domain/entities/joke.dart';

abstract class JokeRepository {
  Future<Either<Failure, Joke>> getJokes();

  Future<Either<Failure, List<String>>> getFromLocal();
}
