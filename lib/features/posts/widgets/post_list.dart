import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/features/posts/providers/posts_notifier.dart';
import 'post_card.dart';

class PostList extends ConsumerStatefulWidget {
  const PostList({super.key});

  @override
  ConsumerState<PostList> createState() => _PostListState();
}

class _PostListState extends ConsumerState<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(postsNotifierProvider.notifier).fetchInitialPosts());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) { // Trigger before reaching the end
      ref.read(postsNotifierProvider.notifier).fetchMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final postsState = ref.watch(postsNotifierProvider);
    
    if (postsState.posts.isEmpty && postsState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (postsState.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.article_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No posts yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Be the first to share a report!',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(postsNotifierProvider.notifier).fetchInitialPosts(),
              child: const Text('Refresh'),
            )
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: postsState.posts.length + (postsState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == postsState.posts.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final post = postsState.posts[index];
        return PostCard(post: post);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}