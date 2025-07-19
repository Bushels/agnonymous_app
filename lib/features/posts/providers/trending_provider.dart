import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agnonymous_app/core/constants/categories.dart';
import 'package:agnonymous_app/data/repositories/post_repository.dart';

final trendingCategoryProvider = FutureProvider<AgriculturalCategory>((ref) async {
  final postRepository = ref.watch(postRepositoryProvider);
  final posts = await postRepository.getPosts(limit: 100); // Fetch last 100 posts
  return AgriculturalCategories.getTrendingCategory(posts.map((e) => e.toJson()).toList());
});
