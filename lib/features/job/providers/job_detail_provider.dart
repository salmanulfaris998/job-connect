import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobconnect/core/models/job_card_model.dart';
import 'package:jobconnect/features/wishlist/providers/wishlist_provider.dart';

class JobDetailState {
  const JobDetailState({required this.job, required this.isSaved});

  final JobCardModel job;
  final bool isSaved;

  JobDetailState copyWith({JobCardModel? job, bool? isSaved}) {
    return JobDetailState(
      job: job ?? this.job,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class JobDetailNotifier extends AutoDisposeNotifier<JobDetailState?> {
  bool _listening = false;

  @override
  JobDetailState? build() {
    _listening = false;
    return null;
  }

  void initialize(JobCardModel job) {
    final isSaved = ref.read(wishlistContainsProvider(job));
    state = JobDetailState(job: job, isSaved: isSaved);

    if (!_listening) {
      _listening = true;
      ref.listen<List<JobCardModel>>(wishlistProvider, (previous, next) {
        final current = state;
        if (current == null) return;

        final updatedSaved = next.any(
          (j) => j.title == current.job.title && j.location == current.job.location,
        );

        if (updatedSaved != current.isSaved) {
          state = current.copyWith(isSaved: updatedSaved);
        }
      });
    }
  }

  void toggleWishlist() {
    final current = state;
    if (current == null) return;
    ref.read(wishlistProvider.notifier).toggle(current.job);
  }
}

final jobDetailProvider = AutoDisposeNotifierProvider<JobDetailNotifier, JobDetailState?>
    (JobDetailNotifier.new);
