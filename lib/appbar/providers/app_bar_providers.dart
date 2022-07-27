import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/appbar/models/drawer_state.dart';

final isDrawerOpenProvider = ChangeNotifierProvider.autoDispose<DrawerState>(
  (ref) => DrawerState(),
);
