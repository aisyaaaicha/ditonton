import 'package:ditonton/presentation/bloc/series/series_bloc.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/series_dummy_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late SeriesDetailBlocHelper seriesDetailBlocHelper;
  late RecommendationsSeriesBlocHelper recommendationsSeriesBlocHelper;
  late WatchlistSeriesBlocHelper watchlistSeriesBlocHelper;

  setUp(() {
    seriesDetailBlocHelper = SeriesDetailBlocHelper();
    registerFallbackValue(SeriesDetailEventHelper());
    registerFallbackValue(SeriesDetailStateHelper());

    recommendationsSeriesBlocHelper = RecommendationsSeriesBlocHelper();
    registerFallbackValue(RecommendationsSeriesEventHelper());
    registerFallbackValue(RecommendationsSeriesStateHelper());

    watchlistSeriesBlocHelper = WatchlistSeriesBlocHelper();
    registerFallbackValue(WatchlistSeriesEventHelper());
    registerFallbackValue(WatchlistSeriesStateHelper());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<SeriesDetailBloc>(create: (_) => seriesDetailBlocHelper),
        BlocProvider<WatchlistSeriesBloc>(
            create: (_) => watchlistSeriesBlocHelper),
        BlocProvider<RecommendationsSeriesBloc>(
            create: (_) => recommendationsSeriesBlocHelper)
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => seriesDetailBlocHelper.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => recommendationsSeriesBlocHelper.state)
        .thenReturn(SeriesHasData(testSeriesList));
    when(() => watchlistSeriesBlocHelper.state)
        .thenReturn(LoadSeriesWatchlistData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series is added to watchlist',
      (WidgetTester tester) async {
    when(() => seriesDetailBlocHelper.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => recommendationsSeriesBlocHelper.state)
        .thenReturn(SeriesHasData(testSeriesList));
    when(() => watchlistSeriesBlocHelper.state)
        .thenReturn(LoadSeriesWatchlistData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(SeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
  testWidgets('Watchlist button should display Snakbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => seriesDetailBlocHelper.state)
        .thenReturn(SeriesDetailHasData(testSeriesDetail));
    when(() => recommendationsSeriesBlocHelper.state)
        .thenReturn(SeriesHasData(testSeriesList));
    when(() => watchlistSeriesBlocHelper.state)
        .thenReturn(LoadSeriesWatchlistData(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(SeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });
}
