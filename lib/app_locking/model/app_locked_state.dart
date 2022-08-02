import 'dart:io';

enum AppLockedState {
  regularState,
  upgradeRequired,
  maintenanceMode;

  String getTitle() {
    switch (this) {
      case AppLockedState.upgradeRequired:
        return 'Upgrade Required';
      case AppLockedState.maintenanceMode:
        return 'Under Maintenance';
      default:
        return '';
    }
  }

  String getDescription() {
    late final bool? isAndroid;

    if (Platform.isAndroid) {
      isAndroid = true;
    } else if (Platform.isIOS) {
      isAndroid = false;
    } else {
      isAndroid = null;
      return '';
    }

    switch (this) {
      case AppLockedState.upgradeRequired:
        return 'Please, to keep using the app upgrade to the latest version on the ${isAndroid ? 'Play Store.' : 'App Store.'}';
      case AppLockedState.maintenanceMode:
        return 'App is under maintenance, please try again later.';
      default:
        return '';
    }
  }
}
