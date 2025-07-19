import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';

final supabase = Supabase.instance.client;

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

final postsProvider = StreamProvider.family<List<Post>, ({int limit, int offset, String? category})>(
    (ref, params) {
  final stream = supabase
      .from('posts')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false)
      .limit(params.limit)
      .range(params.offset, params.offset + params.limit - 1);

  return stream.map((maps) => maps.map((json) => Post.fromJson(json)).toList());
});

final singlePostProvider = FutureProvider.family<Post, String>((ref, postId) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPostById(postId);
});