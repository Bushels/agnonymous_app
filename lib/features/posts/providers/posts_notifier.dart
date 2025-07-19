import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/core/models/post_model.dart';
import 'package:agnonymous_app/data/repositories/post_repository.dart';

// 1. State: A list of posts
class PostsState {
  final List<Post> posts;
  final bool isLoading;
  final bool hasMore;

  PostsState({
    this.posts = const [],
    this.isLoading = false,
    this.hasMore = true,
  });

  PostsState copyWith({
    List<Post>? posts,
    bool? isLoading,
    bool? hasMore,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// 2. Notifier: Manages the state
class PostsNotifier extends StateNotifier<PostsState> {
  final PostRepository _postRepository;
  int _offset = 0;
  String? _category;

  PostsNotifier(this._postRepository) : super(PostsState());

  Future<void> fetchInitialPosts({String? category}) async {
    _offset = 0;
    _category = category;
    state = PostsState(isLoading: true, hasMore: true);
    try {
      final newPosts = await _postRepository.getPosts(category: _category);
      state = state.copyWith(
        posts: newPosts,
        isLoading: false,
        hasMore: newPosts.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchMorePosts() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);
    _offset += 20;

    try {
      final newPosts = await _postRepository.getPosts(offset: _offset, category: _category);
      state = state.copyWith(
        posts: [...state.posts, ...newPosts],
        isLoading: false,
        hasMore: newPosts.isNotEmpty,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void updatePost(Post updatedPost) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        return post.id == updatedPost.id ? updatedPost : post;
      }).toList(),
    );
  }
}

// 3. Provider: Provides the Notifier
final postsNotifierProvider = StateNotifierProvider<PostsNotifier, PostsState>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  return PostsNotifier(postRepository);
});

// Provider for the PostRepository
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});
