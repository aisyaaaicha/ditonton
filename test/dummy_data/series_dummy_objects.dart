import 'package:ditonton/data/models/series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

final testSeries = Series(
  backdropPath: "/jeP3It0ZPY3SKW3632qwLkkIZv3.jpg",
  genreIds: [35],
  id: 32568,
  name: 'Till Death Us Do Part',
  originalName: "Till Death Us Do Part",
  overview:
      "Following the chronicles of the East End working-class Garnett family, headed by patriarch Alf Garnett, a reactionary working-class man who holds racist and anti-socialist views.",
  popularity: 4.321,
  posterPath: "/5r8enLaWs3SnVoInZYsOLZgboki.jpg",
  voteAverage: 7.275,
  voteCount: 20,
);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  episodeRunTime: [1, 2],
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  name: 'name',
  nextEpisodeToAir: 'nextEpisodeToAir',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  status: 'status',
  tagline: 'tagline',
  type: 'type',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistSeries = Series.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesTable = SeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};
