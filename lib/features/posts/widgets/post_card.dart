import 'package:flutter/material.dart';
import '../../../core/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.title != null)
              Text(
                post.title!,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (post.title != null) const SizedBox(height: 8.0),
            Text(post.content),
            const SizedBox(height: 8.0),
            Text(
              'Category: ${post.category}',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8.0),
            Text(
              post.timeAgo,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}