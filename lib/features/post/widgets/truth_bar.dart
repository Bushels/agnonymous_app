import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/post_model.dart';
import '../providers/post_providers.dart';

class TruthBar extends ConsumerStatefulWidget {
  final Post post;
  final Function(String)? onVote;

  const TruthBar({
    super.key,
    required this.post,
    this.onVote,
  });

  @override
  ConsumerState<TruthBar> createState() => _TruthBarState();
}

class _TruthBarState extends ConsumerState<TruthBar> {
  Map<String, int>? _voteStats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVoteStats();
  }

  Future<void> _loadVoteStats() async {
    try {
      final stats = await ref.read(voteProvider.notifier).getVoteStats(widget.post.id);
      if (mounted) {
        setState(() {
          _voteStats = stats;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _voteStats = {
            'truth_votes': 0,
            'partial_truth_votes': 0,
            'questionable_votes': 0,
            'total_votes': 0,
          };
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    final stats = _voteStats!;
    final truthVotes = stats['truth_votes']!;
    final partialVotes = stats['partial_truth_votes']!;
    final questionableVotes = stats['questionable_votes']!;
    final total = stats['total_votes']!;
    
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
              Container(
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
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Voting buttons
          Row(
            children: [
              Expanded(
                child: _buildVoteButton(
                  '✅ Seems True',
                  truthVotes,
                  total,
                  const Color(0xFF10B981),
                  () {
                    widget.onVote?.call('truth');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildVoteButton(
                  '⚡ Partially True',
                  partialVotes,
                  total,
                  const Color(0xFFF59E0B),
                  () {
                    widget.onVote?.call('partial');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildVoteButton(
                  '❓ Questionable',
                  questionableVotes,
                  total,
                  const Color(0xFFEF4444),
                  () {
                    widget.onVote?.call('questionable');
                  },
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