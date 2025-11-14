import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/core/models/job_card_model.dart';

class WishlistNotifier extends Notifier<List<JobCardModel>> {
  @override
  List<JobCardModel> build() => [];

  bool contains(JobCardModel job) {
    return state.any((j) => j.title == job.title && j.location == job.location);
  }

  void add(JobCardModel job) {
    if (!contains(job)) {
      state = [job, ...state];
    }
  }

  void remove(JobCardModel job) {
    state = state
        .where((j) => !(j.title == job.title && j.location == job.location))
        .toList();
  }

  void toggle(JobCardModel job) {
    if (contains(job)) {
      remove(job);
    } else {
      add(job);
    }
  }

  void clear() {
    state = [];
  }
}

final wishlistProvider =
    NotifierProvider<WishlistNotifier, List<JobCardModel>>(
        () => WishlistNotifier());

final wishlistCountProvider = Provider<int>((ref) {
  return ref.watch(wishlistProvider).length;
});

final wishlistContainsProvider =
    Provider.family<bool, JobCardModel>((ref, job) {
  final list = ref.watch(wishlistProvider);
  return list.any((j) => j.title == job.title && j.location == job.location);
});
