import "package:riverpod_annotation/riverpod_annotation.dart";
import "../view/map_list_switch.dart";

part "bottom_nav_controller.g.dart";

@riverpod
class BottomNavController extends _$BottomNavController {
  @override
  int build() => 1;

  void setCurrentIndex(int index) {
    state = index;
  }
}

@riverpod
class ViewTypeController extends _$ViewTypeController {
  @override
  ViewType build() => ViewType.map;

  void setViewType(ViewType viewType) {
    state = viewType;
  }

  void toggleViewType() {
    state = state == ViewType.map ? ViewType.list : ViewType.map;
  }
}
