import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:score_keeper/app_locking/providers/app_locked_providers.dart';
import 'package:score_keeper/app_locking/providers/app_locked_state.dart';
import 'package:score_keeper/app_locking/widgets/app_locked_screen.dart';

class AppLockedServiceConsumer extends ConsumerWidget {
  const AppLockedServiceConsumer({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLockedState = ref.watch(appLockedProviderNotifier);

    print('=== AppLockedState: $appLockedState');


    switch (appLockedState) {
      case AppLockedState.maintenanceMode:
        return const AppLockedScreen(
            appLockedState: AppLockedState.maintenanceMode);
      case AppLockedState.upgradeRequired:
        return const AppLockedScreen(
            appLockedState: AppLockedState.upgradeRequired);
      default:
        return child;
    }
    // ref.listen<AppLockedState>(appLockedProviderNotifier, (previous, next) {
    //   print('=== previous: $previous | next: $next');
    //   if (next != AppLockedState.regularState) {
    //     print('add app locked page with: ${next.name}');
    //     navigateToAppLocked(next, context);
    //   }
    // });
  }

  // Future<void> navigateToAppLocked(
  //   AppLockedState appLockedState,
  //   BuildContext context,
  // ) async {
  //   if (appLockedState != AppLockedState.regularState) {
  //     await Navigator.of(context).push(MaterialPageRoute(
  //         builder: (context) =>
  //             AppLockedScreen(appLockedState: appLockedState)));
  //   }
  // }
}
