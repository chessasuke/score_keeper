import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/analytics/models/event.dart';
import '../../services/analytics/providers/analytics_provider.dart';

class Utils {
  static int calculatePlayerPoints(List<int> pointHistory) {
    if (pointHistory.isEmpty) return 0;
    return pointHistory.reduce((value, element) => value + element);
  }

  static Future<void> launchURL(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      debugPrint('error launch $url: $e');
    }
  }

  static trackEvent({
    required Event event,
    required WidgetRef ref,
  }) {
    ref.read(analyticsProvider).trackEvent(event);
  }
}
