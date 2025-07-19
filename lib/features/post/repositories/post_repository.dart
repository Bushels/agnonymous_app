import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/supabase_config.dart';
import '../../../data/models/post_model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    final response = await supabase
        .from('posts')
        .select('*')
        .order('created_at', ascending: false);
    
    return response.map((json) => Post.fromJson(json)).toList();
  }

  Future<void> createPost({
    String? title,
    required String content,
    required String category,
    String? subcategory,
    List<String> topics = const [],
  }) async {
    await supabase.from('posts').insert({
      'title': title,
      'content': content,
      'category': category,
      'subcategory': subcategory,
      'topics': topics,
      'anonymous_user_id': supabase.auth.currentUser!.id,
    });
  }

  Future<void> voteOnPost(String postId, String voteType) async {
    final userId = supabase.auth.currentUser!.id;
    
    // Map vote types to match SQL function expectations
    String sqlVoteType;
    switch (voteType) {
      case 'truth':
        sqlVoteType = 'true';
        break;
      case 'partial':
        sqlVoteType = 'partial';
        break;
      case 'questionable':
        sqlVoteType = 'false';
        break;
      default:
        sqlVoteType = 'true';
    }
    
    await supabase.rpc('cast_user_vote', params: {
      'post_id_in': postId,
      'user_id_in': userId,
      'vote_type_in': sqlVoteType,
    });
  }

  Future<Map<String, int>> getVoteStats(String postId) async {
    try {
      final result = await supabase.rpc('get_post_vote_stats', params: {
        'post_id_in': postId,
      });
      
      if (result.isNotEmpty) {
        final stats = result[0];
        return {
          'truth_votes': (stats['true_votes'] ?? 0).toInt(),
          'partial_truth_votes': (stats['partial_votes'] ?? 0).toInt(),
          'questionable_votes': (stats['false_votes'] ?? 0).toInt(),
          'total_votes': (stats['total_votes'] ?? 0).toInt(),
        };
      }
      
      return {
        'truth_votes': 0,
        'partial_truth_votes': 0,
        'questionable_votes': 0,
        'total_votes': 0,
      };
    } catch (e) {
      return {
        'truth_votes': 0,
        'partial_truth_votes': 0,
        'questionable_votes': 0,
        'total_votes': 0,
      };
    }
  }

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    // Insert the comment
    await supabase.from('comments').insert({
      'post_id': postId,
      'content': content,
      'anonymous_user_id': supabase.auth.currentUser!.id,
    });

    // Update the comment count on the post
    final currentCount = await supabase
        .from('posts')
        .select('comment_count')
        .eq('id', postId)
        .single();
    
    await supabase
        .from('posts')
        .update({'comment_count': (currentCount['comment_count'] ?? 0) + 1})
        .eq('id', postId);
  }

  Future<List<Map<String, dynamic>>> fetchComments(String postId) async {
    final response = await supabase
        .from('comments')
        .select('*')
        .eq('post_id', postId)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }
}

// Provider for the repository
final postRepositoryProvider = Provider((ref) => PostRepository());