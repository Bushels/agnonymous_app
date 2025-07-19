import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/post_model.dart';
import '../providers/post_providers.dart';

class VoteWidget extends ConsumerWidget {
  final Post post;

  const VoteWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voteStatsAsync = ref.watch(voteStatsProvider(post.id));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🎯',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                'Truth Meter',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const Spacer(),
              voteStatsAsync.when(
                data: (stats) {
                  final total = stats['total_votes'] ?? 0;
                  final truthVotes = stats['truth_votes'] ?? 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getTruthColor(truthVotes, total).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _getTruthLabel(truthVotes, total),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getTruthColor(truthVotes, total),
                      ),
                    ),
                  );
                },
                loading: () => const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Voting buttons
          voteStatsAsync.when(
            data: (stats) {
              final truthVotes = stats['truth_votes'] ?? 0;
              final partialVotes = stats['partial_truth_votes'] ?? 0;
              final questionableVotes = stats['questionable_votes'] ?? 0;
              final total = stats['total_votes'] ?? 0;

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildVoteButton(
                          '✅ Seems True',
                          truthVotes,
                          total,
                          const Color(0xFF10B981),
                          () => ref.read(postsProvider.notifier).vote(post.id, 'truth'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildVoteButton(
                          '⚡ Partially True',
                          partialVotes,
                          total,
                          const Color(0xFFF59E0B),
                          () => ref.read(postsProvider.notifier).vote(post.id, 'partial'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildVoteButton(
                          '❓ Questionable',
                          questionableVotes,
                          total,
                          const Color(0xFFEF4444),
                          () => ref.read(postsProvider.notifier).vote(post.id, 'questionable'),
                        ),
                      ),
                    ],
                  ),
                  
                  if (total > 0) ...[
                    const SizedBox(height: 12),
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 6,
                        child: Row(
                          children: [
                            if (truthVotes > 0)
                              Expanded(
                                flex: truthVotes,
                                child: Container(color: const Color(0xFF10B981)),
                              ),
                            if (partialVotes > 0)
                              Expanded(
                                flex: partialVotes,
                                child: Container(color: const Color(0xFFF59E0B)),
                              ),
                            if (questionableVotes > 0)
                              Expanded(
                                flex: questionableVotes,
                                child: Container(color: const Color(0xFFEF4444)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$total total votes',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (_, __) => Text(
              'Error loading vote data',
              style: TextStyle(
                color: Colors.red.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteButton(String label, int votes, int total, Color color, VoidCallback onTap) {
    final percentage = total > 0 ? (votes / total * 100).round() : 0;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTruthLabel(int truthVotes, int total) {
    if (total < 5) return 'Not enough votes';
    
    final truthPercent = total > 0 ? truthVotes / total : 0.0;
    if (truthPercent > 0.7) return 'Seems True';
    if (truthPercent > 0.4) return 'Partially True';
    return 'Seems Questionable';
  }

  Color _getTruthColor(int truthVotes, int total) {
    final truthPercent = total > 0 ? truthVotes / total : 0.0;
    if (truthPercent > 0.7) return const Color(0xFF10B981);
    if (truthPercent > 0.4) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}