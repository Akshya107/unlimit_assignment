import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unlimit_assignment/data/datasources/local/local_data_source.dart';
import 'package:unlimit_assignment/data/exception.dart';
import 'package:unlimit_assignment/data/models/joke_model.dart';

abstract class RemoteDataSource {
  Future<JokeModel> getJoke();

  Future<List<String>> getJokeFromLocal();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  final LocalDataSource localDataSource;

  const RemoteDataSourceImpl(
      {required this.client, required this.localDataSource});

  @override
  Future<JokeModel> getJoke() async {
    final response = await client.get(
        Uri.parse('https://geek-jokes.sameerkumar.website/api?format=json'));

    if (response.statusCode == 200) {
      final joke = JokeModel.fromJson(json.decode(response.body));
      await localDataSource.storeJoke(joke);
      return joke;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<String>> getJokeFromLocal() async {
    final localJokes = localDataSource.getStoredJokes();
    return localJokes;
  }
}
