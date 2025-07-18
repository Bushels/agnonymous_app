class Post {
  final String id;
  final String? title;
  final String content;
  final String category;
  final String? subcategory;
  final DateTime createdAt;
  final int commentCount;

  Post({
    required this.id,
    this.title,
    required this.content,
    required this.category,
    this.subcategory,
    required this.createdAt,
    this.commentCount = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      subcategory: json['subcategory'],
      createdAt: DateTime.parse(json['created_at']),
      commentCount: json['comment_count'] ?? 0,
    );
  }
}
