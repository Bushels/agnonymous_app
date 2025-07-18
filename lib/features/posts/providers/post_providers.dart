import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final postsProvider = FutureProvider.family<List<Post>, ({int limit, int offset, String? category})>(
    (ref, params) {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPosts(limit: params.limit, offset: params.offset, category: params.category);
});

final singlePostProvider = FutureProvider.family<Post, String>((ref, postId) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPostById(postId);
});