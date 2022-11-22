import 'package:ditonton/data/models/Series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/Series.dart';
import 'package:ditonton/domain/entities/Series_detail.dart';

final testSeries = Series(
  backdropPath: '"/1rO4xoCo4Z5WubK0OwdVll3DPYo.jpg"',
  genreIds: [10765, 10759, 18],
  id: 84773,
  name: 'The Lord of the Rings: The Rings of Power',
  originalName: "The Lord of the Rings: The Rings of Power",
  overview:
      "Beginning in a time of relative peace, we follow an ensemble cast of characters as they confront the re-emergence of evil to Middle-earth. From the darkest depths of the Misty Mountains, to the majestic forests of Lindon, to the breathtaking island kingdom of Númenor, to the furthest reaches of the map, these kingdoms and characters will carve out legacies that live on long after they are gone.",
  popularity: 5205.091,
  posterPath: "/mYLOqiStMxDK3fYZFirgrMt8z5d.jpg",
  voteAverage: 7.7,
  voteCount: 983,
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
