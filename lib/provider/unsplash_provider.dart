import 'package:flutter/material.dart';

import '../json/cards.dart';
import '../services/services.dart';

/*--------------------------- [State] ---------------------------*/
abstract class UnsplashState {}

class UnsplashStateLoading implements UnsplashState {}

class UnsplashStateError implements UnsplashState {
  UnsplashStateError(this.errorMessage);

  final String errorMessage;
}

class UnsplashStateSuccess implements UnsplashState {
  UnsplashStateSuccess(this.cards);

  final List<UnsplashCard> cards;
}

/*--------------------------- [Provider] ---------------------------*/

class UnsplashProvider extends ChangeNotifier {
  UnsplashProvider() {
    // Load cards on create
    loadCards();
  }

  UnsplashState state = UnsplashStateLoading();

  void forceError() {
    state = UnsplashStateError('Showcase for error state.');
    notifyListeners();
  }

  void loadCards() async {
    try {
      state = UnsplashStateLoading();
      notifyListeners();
      final cards = await Services.getCards();
      state = UnsplashStateSuccess(cards);
      notifyListeners();
    } catch (e) {
      state = UnsplashStateError(e.toString());
      notifyListeners();
    }
  }
}
