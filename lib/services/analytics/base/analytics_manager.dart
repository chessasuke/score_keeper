import 'package:rxdart/rxdart.dart';

import '../models/event.dart';
import '../models/user_property.dart';

class AnalyticsManager {
  final PublishSubject<Event> _eventPublisher = PublishSubject<Event>();
  final PublishSubject<UserProperty> _propertyPublisher = PublishSubject<UserProperty>();

  void trackEvent(Event event) {
    _eventPublisher.add(event);
  }

  void setUserProperty(UserProperty property) {
    _propertyPublisher.add(property);
  }

  PublishSubject<Event> get eventPublisher => _eventPublisher;
  PublishSubject<UserProperty> get propertyPublisher => _propertyPublisher;
}

class AnalyticsKeys {
  static const exception = 'exception';
  static const actionType = 'actionType';
}
