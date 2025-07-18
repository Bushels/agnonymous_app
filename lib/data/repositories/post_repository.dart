import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/models/post_model.dart';
import '../../core/errors/app_exceptions.dart';

class PostRepository {
  final _supabase = Supabase.instance.client;
  static const int _pageSize = 20;

  Future<List<Post>> getPosts({
    int limit = _pageSize,
    int offset = 0,
    String? category,
  }) async {
    try {
      var query = _supabase.from('posts').select();
      
      if (category != null && category != 'All') {
        query = query.eq('category', category);
      }
      
      final data = await query
          .order('created_at', ascending: false)
          .limit(limit)
          .range(offset, offset + limit - 1);
      
      return data.map((json) => Post.fromJson(json)).toList();
    } catch (e) {
      throw AppException('Failed to load posts: $e');
    }
  }

  Future<void> createPost({
    required String content,
    required String category,
    String? title,
    String? subcategory,
    List<String>? topics,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw AppException('User not authenticated');
      
      await _supabase.from('posts').insert({
        'anonymous_user_id': userId,
        'content': content,
        'category': category,
        'title': title,
        'subcategory': subcategory,
        'topics': topics ?? [],
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw AppException('Failed to create post: $e');
    }
  }

  Future<Post> getPostById(String id) async {
    try {
      final data = await _supabase
          .from('posts')
          .select()
          .eq('id', id)
          .single();
      
      return Post.fromJson(data);
    } catch (e) {
      throw AppException('Failed to get post: $e');
    }
  }
}