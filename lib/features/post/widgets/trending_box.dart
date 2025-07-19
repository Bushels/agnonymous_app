import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/features/posts/providers/trending_provider.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_theme.dart';
import '../screens/trending_posts_screen.dart';

class TrendingBox extends ConsumerWidget {
  const TrendingBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingCategoryAsync = ref.watch(trendingCategoryProvider);
    
    return trendingCategoryAsync.when(
      data: (trendingCategory) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                trendingCategory.color.withOpacity(0.2),
                AppTheme.darkSurface,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: trendingCategory.color.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrendingPostsScreen(category: trendingCategory),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: trendingCategory.color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            trendingCategory.icon,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '🔥 TRENDING',
                                    style: TextStyle(
                                      color: AppTheme.wheatGold,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.wheatGold.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'HOT',
                                      style: TextStyle(
                                        color: AppTheme.wheatGold,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${trendingCategory.name} Reports',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: trendingCategory.color,
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '📊',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Most active category this week',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'View All',
                            style: TextStyle(
                              color: trendingCategory.color,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
    );
  }
}