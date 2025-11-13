import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryFilterNotifier extends Notifier<int> {
  @override
  int build() => 0; // default selected index

  void select(int index) {
    state = index;
  }
}

final categoryFilterProvider =
    NotifierProvider<CategoryFilterNotifier, int>(() {
  return CategoryFilterNotifier();
});
