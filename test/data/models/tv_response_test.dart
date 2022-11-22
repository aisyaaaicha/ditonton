import 'dart:convert';

import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tSeriesModel = Result(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tSeriesResponseModel =
      SeriesResponse(seriesList: <Result>[tSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        'results': [
          {
            'backdrop_path': '/path.jpg',
            'genre_ids': [1, 2, 3, 4],
            'id': 1,
            'name': 'name',
            'original_name': 'Original Name',
            'overview': 'Overview',
            'popularity': 1.0,
            'poster_path': '/path.jpg',
            'vote_average': 1.0,
            'vote_count': 1
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
