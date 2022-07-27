
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/analytics_manager.dart';

final analyticsProvider = Provider((ref) {
  return AnalyticsManager();
});
