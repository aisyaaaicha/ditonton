import 'package:ditonton/presentation/bloc/movie/movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late PopularMoviesBlocHelper popularMoviesBlocHelper;

  setUp(() {
    popularMoviesBlocHelper = PopularMoviesBlocHelper();
    registerFallbackValue(PopularMoviesStateHelper());
    registerFallbackValue(PopularMoviesEventHelper());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>(
      create: (_) => popularMoviesBlocHelper,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progressbar when loading',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });
  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state).thenReturn(MoviesLoading());
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => popularMoviesBlocHelper.state)
        .thenReturn(MoviesHasError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
