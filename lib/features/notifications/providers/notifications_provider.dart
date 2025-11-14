import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
  });
}

class NotificationsNotifier extends Notifier<List<NotificationItem>> {
  @override
  List<NotificationItem> build() {
    // Dummy notifications
    return [
      NotificationItem(
        id: '1',
        title: 'New job near you',
        body: 'Delivery Driver opening in Shoranur',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      NotificationItem(
        id: '2',
        title: 'Application viewed',
        body: 'Your application for Painter was viewed',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      NotificationItem(
        id: '3',
        title: 'Job saved',
        body: 'Garden Cleanup was added to your saved jobs',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  void removeById(String id) {
    state = state.where((n) => n.id != id).toList();
  }

  void clearAll() {
    state = [];
  }

  void add(NotificationItem item) {
    state = [item, ...state];
  }
}

final notificationsProvider =
    NotifierProvider<NotificationsNotifier, List<NotificationItem>>(
        () => NotificationsNotifier());

final notificationCountProvider = Provider<int>((ref) {
  final items = ref.watch(notificationsProvider);
  return items.length;
});
