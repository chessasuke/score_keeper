import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/board/providers/game_providers.dart';
import 'package:score_keeper/common/utils/extensions.dart';
import 'package:score_keeper/generated/i18n.dart';
import 'package:score_keeper/navigator/page_manager.dart';
import 'package:score_keeper/navigator/route_utils.dart';

import '../providers/app_bar_providers.dart';

enum DrawerOpenMenuItems {
  home,
  reset,
  help;

  void onTap(WidgetRef ref) {
    switch (this) {
      case DrawerOpenMenuItems.home:
        ref.read(pageManagerProvider).addPage(RoutePath.home);
        break;
      case DrawerOpenMenuItems.reset:
        ref.refresh(gameStateProvider);
        break;
      case DrawerOpenMenuItems.help:
        ref.refresh(gameStateProvider); 
        break;
    }
    Future.delayed(const Duration(milliseconds: 200),
        () => ref.read(isDrawerOpenProvider).close());
  }

}

class DrawerOpenMenu extends StatefulWidget {
  const DrawerOpenMenu({Key? key}) : super(key: key);

  @override
  DrawerOpenMenuState createState() => DrawerOpenMenuState();
}

class DrawerOpenMenuState extends State<DrawerOpenMenu>
    with SingleTickerProviderStateMixin {
  /// parts of the animation
  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 100);
  static const _bottomItemDelayTime = Duration(milliseconds: 150);
  static const _bottomItemTime = Duration(milliseconds: 1000);

  /// duration of the animation
  final _animationDuration = _initialDelayTime +
      (_staggerTime * DrawerOpenMenuItems.values.length) +
      (_itemSlideTime * DrawerOpenMenuItems.values.length) +
      _bottomItemDelayTime +
      _bottomItemTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _bottomItemInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < DrawerOpenMenuItems.values.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    /// Bottom Item
    final bottomItemStartTime =
        Duration(milliseconds: (DrawerOpenMenuItems.values.length * 50)) +
            _bottomItemDelayTime;
    final bottomItemEndTime = bottomItemStartTime + _bottomItemTime;
    _bottomItemInterval = Interval(
      bottomItemStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      bottomItemEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              for (final DrawerOpenMenuItems item in DrawerOpenMenuItems.values)
                _AnimatedMenuItem(
                  interval: _itemSlideIntervals[item.index],
                  item: item,
                  animation: _staggeredController,
                ),
              const Spacer(),
              _BottomItem(
                animation: _staggeredController,
                interval: _bottomItemInterval,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AnimatedMenuItem extends ConsumerWidget {
  const _AnimatedMenuItem({
    required this.item,
    required this.animation,
    required this.interval,
    Key? key,
  }) : super(key: key);

  final Interval interval;
  final DrawerOpenMenuItems item;
  final AnimationController animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final animationPercent = Curves.easeOut.transform(
          interval.transform(animation.value),
        );
        final opacity = animationPercent;
        final slideDistance = (1.0 - animationPercent) * 150;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(slideDistance, 0),
            child: child,
          ),
        );
      },
      child: _MenuItem(item: item),
    );
  }
}

class _MenuItem extends ConsumerWidget {
  const _MenuItem({
    required this.item,
    Key? key,
  }) : super(key: key);

  final DrawerOpenMenuItems item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
      child: InkWell(
        onTap: () => item.onTap(ref),
        child: Text(
          item.name.capitalize(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.animation,
    required this.interval,
    Key? key,
  }) : super(key: key);

  final Interval interval;
  final AnimationController animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final animationPercent = Curves.elasticOut
                .transform(interval.transform(animation.value));
            final opacity = animationPercent.clamp(0.0, 1.0);
            final scale = (animationPercent * 0.5) + 0.5;

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: Text(S.of(context).footerAppbarMenu),
        ),
      ),
    );
  }
}
