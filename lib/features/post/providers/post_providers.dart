import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/post_model.dart';
import '../repositories/post_repository.dart';

// AsyncNotifier for posts - this is the core solution
class PostsNotifier extends AsyncNotifier<List<Post>> {
  @override
  Future<List<Post>> build() async {
    // Fetch the posts from the repository
    return ref.read(postRepositoryProvider).fetchPosts();
  }

  /// Called from the UI to create a new post
  Future<void> createPost({
    String? title,
    required String content,
    required String category,
    String? subcategory,
    List<String> topics = const [],
  }) async {
    await ref.read(postRepositoryProvider).createPost(
      title: title,
      content: content,
      category: category,
      subcategory: subcategory,
      topics: topics,
    );
    // After the post is created successfully, we invalidate our own provider
    // This tells Riverpod to re-run the `build` method, fetching the new list
    ref.invalidateSelf();
  }

  /// Called from the vote widget - with optimistic updates
  Future<void> vote(String postId, String voteType) async {
    // First, optimistically update the local state
    final currentState = state;
    if (currentState is AsyncData<List<Post>>) {
      final currentPosts = currentState.value;
      final postIndex = currentPosts.indexWhere((p) => p.id == postId);
      
      if (postIndex != -1) {
        final oldPost = currentPosts[postIndex];
        // Create an optimistic update
        final updatedPost = oldPost.copyWith(
          truthVotes: voteType == 'truth' ? oldPost.truthVotes + 1 : oldPost.truthVotes,
          partialTruthVotes: voteType == 'partial' ? oldPost.partialTruthVotes + 1 : oldPost.partialTruthVotes,
          questionableVotes: voteType == 'questionable' ? oldPost.questionableVotes + 1 : oldPost.questionableVotes,
        );
        
        // Update the state immediately for instant UI feedback
        final updatedPosts = [...currentPosts];
        updatedPosts[postIndex] = updatedPost;
        state = AsyncData(updatedPosts);
      }
    }

    try {
      // Then perform the actual database operation
      await ref.read(postRepositoryProvider).voteOnPost(postId, voteType);
      // Refresh from database to get the real state
      ref.invalidateSelf();
    } catch (e) {
      // If the vote fails, refresh to get the correct state back
      ref.invalidateSelf();
      rethrow;
    }
  }

  /// Called from comment widgets
  Future<void> addComment(String postId, String content) async {
    await ref.read(postRepositoryProvider).addComment(
      postId: postId,
      content: content,
    );
    // Invalidate to refresh post data with updated comment count
    ref.invalidateSelf();
  }

  /// Get vote stats for a specific post
  Future<Map<String, int>> getVoteStats(String postId) async {
    return ref.read(postRepositoryProvider).getVoteStats(postId);
  }

  /// Get comments for a specific post
  Future<List<Map<String, dynamic>>> getComments(String postId) async {
    return ref.read(postRepositoryProvider).fetchComments(postId);
  }
}

// The main posts provider using AsyncNotifier
final postsProvider = AsyncNotifierProvider<PostsNotifier, List<Post>>(() {
  return PostsNotifier();
});

// Provider for vote stats of a specific post
final voteStatsProvider = FutureProvider.family<Map<String, int>, String>((ref, postId) async {
  return ref.read(postsProvider.notifier).getVoteStats(postId);
});

// Provider for comments of a specific post
final commentsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, postId) async {
  return ref.read(postsProvider.notifier).getComments(postId);
});