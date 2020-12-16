import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:unsplash_app/pagination_state.dart';

import '../json/cards.dart';
import '../services/services.dart';

class UnsplashProvider extends ChangeNotifier {

  UnsplashProvider() {
    loadFirst();
  }

  PaginationState get state => _state;

  PaginationState _state = PaginationState.firstPageLoading();

  List<UnsplashCard> _data = [];
  final int perPage = 10;
  int _totalCount = 0;
  bool get _hasNext => _data.length < _totalCount;
  int get _page => (_data.length / perPage).ceil();

  Future<void> loadFirst() async{
    _changeState(PaginationState.firstPageLoading());
      try{
        final response  = await Services.getCards(perPage: perPage);
        _totalCount = response.totalCount;
        _data = response.cards;

        _changeState(PaginationState.firstPage(data: _data));
      } catch (e){
        log(e);
        _changeState(PaginationState.firstPageError(errorMessage: 'Error Data'));
      }
  }

  Future<void> loadNextPage() async{
    if(_state is NextPageLoading) return;

    if(!_hasNext) return;



    _changeState(PaginationState.nextPageLoading(data: _data));

    try{
      final nextDataResponse = await Services.getCards(perPage: perPage, page: _page + 1);
      _data.addAll(nextDataResponse.cards);


      _changeState(PaginationState.nextPage(data: _data));
    } catch(e) {
      log(e);
      _changeState(PaginationState.nextPageError(data: _data, errorMessage: 'Next Page Error'));
    }


  }

  Future<void> loadRefresh() async{
    if(_state is RefreshLoading) return;

    if(_state is NextPageLoading) return;

    _changeState(PaginationState.refreshLoading(data: _data));

    try{
       final response = await Services.getCards(perPage: perPage);
       _data = response.cards;

       _changeState(PaginationState.refresh(data: _data));

    } catch (e) {
      log(e);
      _changeState(PaginationState.refreshError(data: _data, errorMessage: 'Refresh Error'));
    }
  }

  void _changeState(PaginationState newState) {
    _state = newState;
    notifyListeners();
  }
}
