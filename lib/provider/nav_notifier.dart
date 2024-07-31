import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavNotifier extends Notifier<int> {
  NavNotifier();
  @override
  int build() {
    return 0;
  }

  void onChangeNavView({required int selectedTabView}) {
    state = selectedTabView;
  }
}

final currentNavScreenProvider =
    NotifierProvider<NavNotifier, int>(() => NavNotifier());
