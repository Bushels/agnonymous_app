class Post {
  final String id;
  final String? title;
  final String content;
  final String category;
  final String? subcategory;
  final DateTime createdAt;
  final int commentCount;
  final List<String> topics;
  final int truthVotes;
  final int partialTruthVotes;
  final int questionableVotes;

  Post({
    required this.id,
    this.title,
    required this.content,
    required this.category,
    this.subcategory,
    required this.createdAt,
    this.commentCount = 0,
    this.topics = const [],
    this.truthVotes = 0,
    this.partialTruthVotes = 0,
    this.questionableVotes = 0,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      subcategory: json['subcategory'],
      createdAt: DateTime.parse(json['created_at']),
      commentCount: (json['comment_count'] ?? 0).toInt(),
      topics: json['topics'] != null ? List<String>.from(json['topics']) : [],
      truthVotes: (json['truth_votes'] ?? 0).toInt(),
      partialTruthVotes: (json['partial_truth_votes'] ?? 0).toInt(),
      questionableVotes: (json['questionable_votes'] ?? 0).toInt(),
    );
  }

  double get truthPercentage {
    final total = truthVotes + partialTruthVotes + questionableVotes;
    if (total == 0) return 0.0;
    return truthVotes / total;
  }

  String get truthLabel {
    final total = truthVotes + partialTruthVotes + questionableVotes;
    if (total < 5) return 'Not enough votes';
    
    final truthPercent = truthPercentage;
    if (truthPercent > 0.7) return 'Seems True';
    if (truthPercent > 0.4) return 'Partially True';
    return 'Seems Questionable';
  }

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? category,
    String? subcategory,
    DateTime? createdAt,
    int? commentCount,
    List<String>? topics,
    int? truthVotes,
    int? partialTruthVotes,
    int? questionableVotes,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      createdAt: createdAt ?? this.createdAt,
      commentCount: commentCount ?? this.commentCount,
      topics: topics ?? this.topics,
      truthVotes: truthVotes ?? this.truthVotes,
      partialTruthVotes: partialTruthVotes ?? this.partialTruthVotes,
      questionableVotes: questionableVotes ?? this.questionableVotes,
    );
  }
}