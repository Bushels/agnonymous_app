import 'package:agnonymous_app/features/post/widgets/trending_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/post_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agnonymous'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // TODO: Show about dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const TrendingBox(),
          const Expanded(
            child: PostList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/create'),
        icon: const Icon(Icons.add),
        label: const Text('Share Report'),
      ),
    );
  }
}