import 'package:flutter/material.dart';

mixin PaginationTrigger<T extends StatefulWidget> on State<T> {
  @protected
  ScrollController get paginationScrollController;

  @protected
  double paginationBottomThresholdPx = 150.0;

  @protected
  /// Calls when scroll position of [paginationScrollController] reach the end - [paginationBottomThresholdPx]
  void onPaginationTriggered();

  @override
  void initState() {
    super.initState();
    paginationScrollController?.addListener(_paginationScrollTrigger);
  }

  void _paginationScrollTrigger() {
    if (paginationScrollController.offset >=
        paginationScrollController.position.maxScrollExtent - paginationBottomThresholdPx) {
      onPaginationTriggered();
    }
  }
}