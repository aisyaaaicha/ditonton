import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/data/models/series_model.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/series_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesRemoteDataSource mockRemoteDataSource;
  late MockSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSeriesRemoteDataSource();
    mockLocalDataSource = MockSeriesLocalDataSource();
    repository = SeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tSeriesModel = Result(
    backdropPath: '/thCj6VEVQlFlup4aJ74kdRhfujB.jpg',
    genreIds: [18],
    id: 82428,
    originalName: 'All American',
    overview:
        'When a rising high school football player from South Central L.A. is recruited to play for Beverly Hills High, the wins, losses and struggles of two families from vastly different worlds - Compton and Beverly Hills - begin to collide. Inspired by the life of pro football player Spencer Paysinger.',
    popularity: 99.077,
    posterPath: '/bpmZDwQfUPVKCLfIivbWnJQT6wU.jpg',
    name: 'All American',
    voteAverage: 8.3,
    voteCount: 342,
  );

  final tSeries = Series(
    backdropPath: '/thCj6VEVQlFlup4aJ74kdRhfujB.jpg',
    genreIds: [18],
    id: 82428,
    originalName: 'All American',
    overview:
        'When a rising high school football player from South Central L.A. is recruited to play for Beverly Hills High, the wins, losses and struggles of two families from vastly different worlds - Compton and Beverly Hills - begin to collide. Inspired by the life of pro football player Spencer Paysinger.',
    popularity: 99.077,
    posterPath: '/bpmZDwQfUPVKCLfIivbWnJQT6wU.jpg',
    name: 'All American',
    voteAverage: 8.3,
    voteCount: 342,
  );

  final tSeriesModelList = <Result>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];

  group('On The Air Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Series', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getPopularSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Series', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Series Detail', () {
    final tId = 6;
    final tSeriesResponse = SeriesDetailModel(
      adult: false,
      backdropPath: 'backdropPath',
      episodeRunTime: [1, 2],
      genres: [GenreModel(id: 1, name: 'Action')],
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

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenAnswer((_) async => tSeriesResponse);
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tSeriesList = <Result>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Series', () {
    final tQuery = 'all american';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistSeries(tId);
      // assert
      expect(result, false);
    });
  });
}
