import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unlimit_assignment/domain/usecases/get_jokes.dart';

part 'joke_event.dart';

part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetNewJoke _getNewJoke;

  JokeBloc(this._getNewJoke) : super(JokeInitial()) {
    on<FetchNewJokeEvent>((event, emit) async {
      final localRes = await _getNewJoke.executeFromLocal();
      localRes.fold((failure) async {
        final result = await _getNewJoke.execute();
        result.fold((failure) {
          emit(JokeError(msg: failure.message));
        }, (result) {
          emit(JokeHasData(result: result.text));
        });
      }, (result) {
        emit(JokeHasData(localRes: result));
      });
      final result = await _getNewJoke.execute();
      result.fold((failure) {
        emit(JokeError(msg: failure.message));
      }, (result) {
        emit(JokeInitial());
        emit(JokeHasData(result: result.text));
      });
      // fromRemote(emit);
    });
  }
}
