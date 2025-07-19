import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/features/posts/providers/posts_notifier.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/post_card.dart';

class TrendingPostsScreen extends ConsumerStatefulWidget {
  final AgriculturalCategory category;

  const TrendingPostsScreen({super.key, required this.category});

  @override
  ConsumerState<TrendingPostsScreen> createState() => _TrendingPostsScreenState();
}

class _TrendingPostsScreenState extends ConsumerState<TrendingPostsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(postsNotifierProvider.notifier)
        .fetchInitialPosts(category: widget.category.id));
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(postsNotifierProvider.notifier).fetchMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.category.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.category.icon,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔥 Trending',
                  style: TextStyle(
                    color: AppTheme.wheatGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.category.name} Reports',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.category.color.withOpacity(0.1),
              AppTheme.darkBg,
              AppTheme.darkSurface.withOpacity(0.5),
            ],
          ),
        ),
        child: _buildBody(postsState),
      ),
    );
  }

  Widget _buildBody(PostsState postsState) {
    if (postsState.posts.isEmpty && postsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (postsState.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: widget.category.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.category.icon,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No ${widget.category.name} Reports Yet',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Be the first to share insights about ${widget.category.name.toLowerCase()}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.category.color.withOpacity(0.3),
                  widget.category.color.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: widget.category.color.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: widget.category.color,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    widget.category.icon,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${postsState.posts.length} Reports',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: widget.category.color,
                        ),
                      ),
                      Text(
                        'in ${widget.category.name}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.wheatGold,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'TRENDING',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == postsState.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return PostCard(post: postsState.posts[index]);
              },
              childCount: postsState.posts.length + (postsState.hasMore ? 1 : 0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}