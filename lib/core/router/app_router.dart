import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/posts/screens/home_screen.dart';
import '../../features/create_post/screens/create_post_screen.dart';
import '../../features/posts/screens/post_detail_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'create',
          name: 'create_post',
          builder: (context, state) => const CreatePostScreen(),
        ),
        GoRoute(
          path: 'post/:id',
          name: 'post_detail',
          builder: (context, state) {
            final postId = state.pathParameters['id']!;
            return PostDetailScreen(postId: postId);
          },
        ),
      ],
    ),
  ],
);

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Page not found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}