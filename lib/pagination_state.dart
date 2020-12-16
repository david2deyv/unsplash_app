import 'package:flutter/material.dart';
import 'package:unsplash_app/json/cards.dart';

abstract class PaginationState {
  factory PaginationState.refreshLoading({@required List<UnsplashCard> data}) = RefreshLoading;

  factory PaginationState.refresh({@required List<UnsplashCard> data}) = Refresh;

  factory PaginationState.refreshError({
    @required List<UnsplashCard> data,
    @required String errorMessage,
  }) = RefreshError;

  factory PaginationState.firstPageLoading() = FirstPageLoading;

  factory PaginationState.firstPage({@required List<UnsplashCard> data}) = FirstPage;

  factory PaginationState.firstPageError({@required String errorMessage}) = FirstPageError;

  factory PaginationState.nextPageLoading({@required List<UnsplashCard> data}) = NextPageLoading;

  factory PaginationState.nextPage({@required List<UnsplashCard> data}) = NextPage;

  factory PaginationState.nextPageError({
    @required List<UnsplashCard> data,
    @required String errorMessage,
  }) = NextPageError;
}

/*--------------------------- [Refresh] ---------------------------*/

@required
class RefreshLoading implements PaginationState {
  const RefreshLoading({this.data});

  final List<UnsplashCard> data;
}

class Refresh implements PaginationState {
  const Refresh({this.data});

  final List<UnsplashCard> data;
}

class RefreshError implements PaginationState {
  const RefreshError({@required this.data, @required this.errorMessage});

  final List<UnsplashCard> data;
  final String errorMessage;
}

/*--------------------------- [First page] ---------------------------*/

class FirstPageLoading implements PaginationState {
  const FirstPageLoading({@required this.data});

  final List<UnsplashCard> data;
}

class FirstPage implements PaginationState {
  const FirstPage({@required this.data});

  final List<UnsplashCard> data;
}

class FirstPageError implements PaginationState {
  const FirstPageError({@required this.errorMessage});

  final String errorMessage;
}
/*--------------------------- [Next Page] ---------------------------*/

class NextPageLoading implements PaginationState {
  const NextPageLoading({@required this.data});

  final List<UnsplashCard> data;
}

class NextPage implements PaginationState {
  const NextPage({
    @required this.data,
  });

  final List<UnsplashCard> data;
}

class NextPageError implements PaginationState {
  const NextPageError({@required this.data, @required this.errorMessage});

  final List<UnsplashCard> data;
  final String errorMessage;
}