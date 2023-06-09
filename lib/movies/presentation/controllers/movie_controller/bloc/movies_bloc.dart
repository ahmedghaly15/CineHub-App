import 'dart:async';

import 'package:bloc/bloc.dart';

import '/core/usecase/base_usecase.dart';
import '/core/utils/enums.dart';
import '/movies/domain/usecases/get_now_playing_usecase.dart';
import '/movies/domain/usecases/get_popular_movies_usecase.dart';
import '/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'movies_events.dart';
import 'movies_states.dart';

class MoviesBloc extends Bloc<MoviesEvents, MoviesStates> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc({
    required this.getNowPlayingMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getTopRatedMoviesUseCase,
  }) : super(const MoviesStates()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);

    on<GetPopularMoviesEvent>(_getPopularMovies);

    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
    GetNowPlayingMoviesEvent event,
    Emitter<MoviesStates> emit,
  ) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            nowPlayingState: RequestState.error,
            nowPlayingErrorMessage: failure.message,
          ),
        );
      },
      (movies) {
        emit(
          state.copyWith(
            nowPlayingState: RequestState.loaded,
            nowPlayingMovies: movies,
          ),
        );
      },
    );
  }

  FutureOr<void> _getPopularMovies(
    GetPopularMoviesEvent event,
    Emitter<MoviesStates> emit,
  ) async {
    final result = await getPopularMoviesUseCase(const NoParameters());
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            popularState: RequestState.error,
            popularErrorMessage: failure.message,
          ),
        );
      },
      (movies) {
        emit(
          state.copyWith(
            popularMovies: movies,
            popularState: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTopRatedMovies(
    GetTopRatedMoviesEvent event,
    Emitter<MoviesStates> emit,
  ) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            topRatedErrorMessage: failure.message,
            topRatedState: RequestState.error,
          ),
        );
      },
      (movies) {
        emit(
          state.copyWith(
            topRatedMovies: movies,
            topRatedState: RequestState.loaded,
          ),
        );
      },
    );
  }
}
