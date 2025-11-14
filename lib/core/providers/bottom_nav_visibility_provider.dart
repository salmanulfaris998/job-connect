import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavVisibilityNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void show() => state = true;

  void hide() => state = false;

  void setVisible(bool visible) => state = visible;
}

final bottomNavVisibilityProvider =
    NotifierProvider<BottomNavVisibilityNotifier, bool>(
        () => BottomNavVisibilityNotifier());
