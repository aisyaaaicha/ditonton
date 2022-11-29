import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late MovieDetailBlocHelper movieDetailBlocHelper;
  late RecommendationMovieBlocHelper recommendationMovieBlocHelper;
  late WatchlistMovieBlocHelper watchlistMovieBlocHelper;

  setUp(() {
    movieDetailBlocHelper = MovieDetailBlocHelper();
    registerFallbackValue(MovieDetailEventHelper());
    registerFallbackValue(MovieDetailStateHelper());

    recommendationMovieBlocHelper = RecommendationMovieBlocHelper();
    registerFallbackValue(RecommendationMovieEventHelper());
    registerFallbackValue(RecommendationMovieStateHelper());

    watchlistMovieBlocHelper = WatchlistMovieBlocHelper();
    registerFallbackValue(WatchlistMovieEventHelper());
    registerFallbackValue(WatchlistMovieStateHelper());
  });

  Widget _makeTesttableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (_) => movieDetailBlocHelper),
        BlocProvider<WatchlistMovieBloc>(
            create: (_) => watchlistMovieBlocHelper),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => recommendationMovieBlocHelper,
        )
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchlistButtonIon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTesttableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);
    await tester.pumpWidget(_makeTesttableWidget(MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => movieDetailBlocHelper.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => recommendationMovieBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));
    when(() => watchlistMovieBlocHelper.state)
        .thenReturn(LoadWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTesttableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
