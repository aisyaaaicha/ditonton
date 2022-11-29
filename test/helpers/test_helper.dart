import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/data/datasources/db/movie_database_helper.dart';
import 'package:ditonton/data/datasources/db/series_database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/bloc/series/series_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:http/io_client.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  SeriesRepository,
  SeriesRemoteDataSource,
  SeriesLocalDataSource,
  SeriesDatabaseHelper,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}

class NowPlayingMoviesEventHelper extends Fake implements MovieBlocEvent {}

class NowPlayingMoviesStateHelper extends Fake implements MovieBlocState {}

class NowPlayingMoviesBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements NowPlayingMovieBloc {}

class PopularMoviesEventHelper extends Fake implements MovieBlocState {}

class PopularMoviesStateHelper extends Fake implements MovieBlocState {}

class PopularMoviesBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements PopularMoviesBloc {}

class TopRatedMoviesEventHelper extends Fake implements MovieBlocEvent {}

class TopRatedMoviesStateHelper extends Fake implements MovieBlocState {}

class TopRatedMovieBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements TopRatedMoviesBloc {}

class MovieDetailEventHelper extends Fake implements MovieBlocEvent {}

class MovieDetailStateHelper extends Fake implements MovieBlocState {}

class MovieDetailBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements MovieDetailBloc {}

class RecommendationMovieEventHelper extends Fake implements MovieBlocEvent {}

class RecommendationMovieStateHelper extends Fake implements MovieBlocState {}

class RecommendationMovieBlocHelper
    extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements RecommendationMovieBloc {}

class WatchlistMovieEventHelper extends Fake implements MovieBlocEvent {}

class WatchlistMovieStateHelper extends Fake implements MovieBlocState {}

class WatchlistMovieBlocHelper extends MockBloc<MovieBlocEvent, MovieBlocState>
    implements WatchlistMovieBloc {}

class NowPlayingSeriesEventHelepr extends Fake implements SeriesEvent {}

class NowPlayingSeriesStateHelper extends Fake implements SeriesState {}

class NowPlayingSeriesBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements NowPlayingSeriesBloc {}

class PopularSeriesEventHelper extends Fake implements SeriesEvent {}

class PopularSeriesStateHelper extends Fake implements SeriesState {}

class PopularSeriesBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements PopularSeriesBloc {}

class TopRatedSeriesEventHelper extends Fake implements SeriesEvent {}

class TopRatedSeriesStateHelper extends Fake implements SeriesState {}

class TopRatedSeriesBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements TopRatedSeriesBloc {}

class SeriesDetailEventHelper extends Fake implements SeriesEvent {}

class SeriesDetailStateHelper extends Fake implements SeriesState {}

class SeriesDetailBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements SeriesDetailBloc {}

class RecommendationsSeriesEventHelper extends Fake implements SeriesEvent {}

class RecommendationsSeriesStateHelper extends Fake implements SeriesState {}

class RecommendationsSeriesBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements RecommendationsSeriesBloc {}

class WatchlistSeriesEventHelper extends Fake implements SeriesEvent {}

class WatchlistSeriesStateHelper extends Fake implements SeriesState {}

class WatchlistSeriesBlocHelper extends MockBloc<SeriesEvent, SeriesState>
    implements WatchlistSeriesBloc {}
