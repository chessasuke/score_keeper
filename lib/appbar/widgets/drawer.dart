import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/app_bar_providers.dart';
import 'drawer_open_menu.dart';

class AppBarDrawer extends ConsumerStatefulWidget {
  const AppBarDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends ConsumerState<AppBarDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();
    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    ref.read(isDrawerOpenProvider).addListener(_drawerStateListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : const DrawerOpenMenu(),
        );
      },
    );
  }

  void _drawerStateListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _toggleDrawer());
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0 ||
        _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (mounted) {
      if (_isDrawerOpen()) {
        _drawerSlideController.reverse();
      } else {
        _drawerSlideController.forward();
      }
    }
  }

  @override
  void dispose() {
    _drawerSlideController.removeListener(_drawerStateListener);
    _drawerSlideController.dispose();
    super.dispose();
  }
}
