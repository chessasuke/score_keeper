import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/appbar/providers/app_bar_providers.dart';
import 'package:score_keeper/common/constants/display_properties.dart';

import 'app_name.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize =>
      const Size.fromHeight(DisplayProperties.appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AppName(height: DisplayProperties.appbarHeight),
      iconTheme: const IconThemeData(color: Colors.black),
      leadingWidth: 100,
      toolbarHeight: DisplayProperties.appbarHeight,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: const [_DrawerIcon()],
    );
  }
}

class _DrawerIcon extends ConsumerWidget {
  const _DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(isDrawerOpenProvider).isOpen;
    return IconButton(
        onPressed: () => ref.read(isDrawerOpenProvider).toggle(),
        icon: Icon(isOpen ? Icons.clear : Icons.menu));
  }
}
