import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/post_providers.dart';
import '../widgets/post_card.dart';
import '../widgets/trending_box.dart';
import 'create_post_screen.dart';
import 'search_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkBg,
              AppTheme.primaryGreen.withOpacity(0.05),
              AppTheme.darkBg,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 280,
              floating: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchScreen()),
                    );
                  },
                  icon: const Icon(Icons.search),
                  tooltip: 'Search Hot Tips',
                ),
                const SizedBox(width: 8),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: const SizedBox.shrink(), // Remove title to prepare for logo
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryGreen.withOpacity(0.3),
                        AppTheme.earthBrown.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        '🌾',
                        style: TextStyle(fontSize: 64),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Truth in Agriculture',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Stats Row
            SliverToBoxAdapter(
              child: Container(
                height: 127,
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildStatCard('Total Reports', _getTotalReports(postsAsync), '📊', AppTheme.lightGreen),
                    _buildStatCard('Total Comments', _getTotalComments(postsAsync), '💬', AppTheme.wheatGold),
                    _buildStatCard('Total Votes', _getTotalVotes(postsAsync), '🗳️', AppTheme.accentGreen),
                    _buildStatCard('Truth Meter', _getTruthMeter(postsAsync), '🎯', AppTheme.primaryGreen),
                  ],
                ),
              ),
            ),

            // Trending Box
            const SliverToBoxAdapter(
              child: TrendingBox(),
            ),

            // Posts
            postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.primaryGreen.withOpacity(0.2),
                                  AppTheme.earthBrown.withOpacity(0.2),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text('🌱', style: TextStyle(fontSize: 60)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No reports yet',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Be the first to share the truth',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => BeautifulPostCard(post: posts[index]),
                      childCount: posts.length,
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: AppTheme.wheatGold,
        foregroundColor: Colors.black,
        icon: const Text('✍️', style: TextStyle(fontSize: 20)),
        label: const Text(
          'Hot Tip',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  String _getTotalReports(AsyncValue postsAsync) {
    return postsAsync.when(
      data: (dynamic posts) => '${(posts as List).length}',
      loading: () => '...',
      error: (_, __) => '0',
    );
  }

  String _getTotalComments(AsyncValue postsAsync) {
    return postsAsync.when(
      data: (dynamic posts) {
        int totalComments = 0;
        for (final post in posts as List) {
          totalComments += (post.commentCount as num).toInt();
        }
        return totalComments > 999 ? '${(totalComments / 1000).toStringAsFixed(1)}K' : '$totalComments';
      },
      loading: () => '...',
      error: (_, __) => '0',
    );
  }

  String _getTotalVotes(AsyncValue postsAsync) {
    return postsAsync.when(
      data: (dynamic posts) {
        final postList = posts as List;
        if (postList.isEmpty) return '0';
        
        int totalVotes = 0;
        
        for (final post in postList) {
          totalVotes += (post.truthVotes as num).toInt() + (post.partialTruthVotes as num).toInt() + (post.questionableVotes as num).toInt();
        }
        
        return totalVotes > 999 ? '${(totalVotes / 1000).toStringAsFixed(1)}K' : '$totalVotes';
      },
      loading: () => '...',
      error: (_, __) => '0',
    );
  }

  String _getTruthMeter(AsyncValue postsAsync) {
    return postsAsync.when(
      data: (dynamic posts) {
        final postList = posts as List;
        if (postList.isEmpty) return '0%';
        
        int totalVotes = 0;
        int truthVotes = 0;
        
        for (final post in postList) {
          totalVotes += (post.truthVotes as num).toInt() + (post.partialTruthVotes as num).toInt() + (post.questionableVotes as num).toInt();
          truthVotes += (post.truthVotes as num).toInt();
        }
        
        if (totalVotes == 0) return 'N/A';
        
        final percentage = (truthVotes / totalVotes * 100).round();
        return '$percentage%';
      },
      loading: () => '...',
      error: (_, __) => '0%',
    );
  }

  Widget _buildStatCard(String label, String value, String emoji, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              Icon(Icons.trending_up, color: color, size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}