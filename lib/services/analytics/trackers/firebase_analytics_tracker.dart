import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

import '../base/analytics_manager.dart';
import '../models/event.dart';
import '../models/user_property.dart';

class FirebaseAnalyticsTracker {
  FirebaseAnalyticsTracker(this.analyticsManager) {
    _analytics = FirebaseAnalytics.instance;
    if (isInterestedInEvents()) {
      subscribeToEvents();
    }

    if (isInterestedInUserProperties()) {
      subscribeToUserProperties();
    }
  }

  late AnalyticsManager analyticsManager;
  static late final FirebaseAnalytics _analytics;

  bool isInterestedInEvents() => true;
  bool isInterestedInUserProperties() => true;

  void subscribeToEvents() {
    analyticsManager.eventPublisher
        .where((event) => acceptEvent(event))
        .map((event) => transformEvent(event))
        .listen((value) {
      logEvent(value);
      reportEvent(value);
    });
  }

  void subscribeToUserProperties() {
    analyticsManager.propertyPublisher
        .where((property) => acceptUserProperty(property))
        .map((property) => transformProperty(property))
        .listen((value) {
      logUserProperty(value);
      reportProperty(value);
    });
  }

  bool acceptEvent(Event event) => true;
  void logEvent(Event event) => debugPrint('New event: ${event.name}');
  Event transformEvent(Event event) => event;

  bool acceptUserProperty(UserProperty property) => true;
  void logUserProperty(UserProperty property) =>
      debugPrint('New user property: ${property.key}');
  UserProperty transformProperty(UserProperty property) => property;

  void reportEvent(Event event) {
    _analytics.logEvent(
      name: event.name,
      parameters: event.params,
    );
  }

  void reportProperty(UserProperty property) {
    _analytics.setUserProperty(
      name: property.key,
      value: property.value,
    );
  }
}
