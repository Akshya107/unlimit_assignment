import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:unlimit_assignment/data/datasources/local/local_data_source.dart';
import 'package:unlimit_assignment/data/datasources/remote/remote_data_source.dart';
import 'package:unlimit_assignment/data/exception.dart';
import 'package:unlimit_assignment/data/failure.dart';
import 'package:unlimit_assignment/domain/entities/joke.dart';
import 'package:unlimit_assignment/domain/repositories/joke_repository.dart';

class JokeRepositoryImpl implements JokeRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  const JokeRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Joke>> getJokes() async {
    try {
      final result = await remoteDataSource.getJoke();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFromLocal() async {
    final result = await localDataSource.getStoredJokes();
    if (result.isEmpty) {
      return const Left(ServerFailure(''));
    } else {
      return Right(result);
    }
  }
}
