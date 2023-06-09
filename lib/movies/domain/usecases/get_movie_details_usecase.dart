import 'package:dartz/dartz.dart';

import '../entities/movie_details_parameters.dart';
import '../repository/movies_repo.dart';
import '/core/errors/failure.dart';
import '/core/usecase/base_usecase.dart';
import '/movies/domain/entities/movie_details.dart';

class GetMovieDetailsUseCase
    extends BaseUseCase<MovieDetails, MovieDetailsParameters> {
  final MoviesRepo moviesRepo;

  GetMovieDetailsUseCase(this.moviesRepo);

  @override
  Future<Either<Failure, MovieDetails>> call(
    MovieDetailsParameters parameters,
  ) async {
    return await moviesRepo.getMovieDetails(parameters);
  }
}
