import 'package:shared_preferences/shared_preferences.dart';
import 'package:unlimit_assignment/data/models/joke_model.dart';

abstract class LocalDataSource {
  Future<List<String>> getStoredJokes();

  Future<void> storeJoke(JokeModel joke);
}

class LocalDataSourceImpl implements LocalDataSource {
  late SharedPreferences sharedPreferences;
  static const maxStoredJokes = 10;

  @override
  Future<List<String>> getStoredJokes() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jokes = sharedPreferences.getStringList('jokes') ?? [];

    return jokes;
  }

  @override
  Future<void> storeJoke(JokeModel model) async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jokes = await getStoredJokes();
    if (jokes.length >= maxStoredJokes) {
      jokes.removeAt(0);
    }

    jokes.add(model.joke);
    await sharedPreferences.setStringList('jokes', jokes);
  }
}
