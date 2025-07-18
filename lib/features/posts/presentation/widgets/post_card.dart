import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../domain/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  Map<String, String> get _categoryEmojis => {
    'Pesticide Use': '🧪',
    'Water Issues': '💧',
    'Labor Conditions': '👷',
    'Environmental Impact': '🌍',
    'Animal Welfare': '🐄',
    'Other': '📋',
  };

  Map<String, Color> get _categoryColors => {
    'Pesticide Use': const Color(0xFF8B4513),
    'Water Issues': const Color(0xFF1E90FF),
    'Labor Conditions': const Color(0xFFFF8C00),
    'Environmental Impact': const Color(0xFF228B22),
    'Animal Welfare': const Color(0xFFDC143C),
    'Other': const Color(0xFF708090),
  };

  @override
  Widget build(BuildContext context) {
    final categoryColor = _categoryColors[post.category] ?? Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: categoryColor,
                  width: 4,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _categoryEmojis[post.category] ?? '📋',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            post.category,
                            style: TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      timeago.format(post.createdAt),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                if (post.title != null && post.title!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    post.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Text('💬', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 6),
                Text(
                  '${post.commentCount} comments',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF2E7D32),
                  ),
                  child: const Row(
                    children: [
                      Text('View Details'),
                      SizedBox(width: 4),
                      Text('→', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
