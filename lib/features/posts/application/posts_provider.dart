import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/post.dart';

final supabase = Supabase.instance.client;

final postsProvider = StreamProvider<List<Post>>((ref) {
  final stream = supabase
      .from('posts')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false);

  return stream.map((maps) => maps.map((json) => Post.fromJson(json)).toList());
});
