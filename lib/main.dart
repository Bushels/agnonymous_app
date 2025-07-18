import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'core/constants/categories.dart';
import 'features/create_post/widgets/category_selector.dart';

// --- SUPABASE CONFIG ---
const String supabaseUrl = 'https://ibgsloyjxdopkvwqcqwh.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImliZ3Nsb3lqeGRvcGt2d3FjcXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2ODYzMzksImV4cCI6MjA2ODI2MjMzOX0.Ik1980vz4s_UxVuEfBm61-kcIzEH-Nt-hQtydZUeNTw';

final supabase = Supabase.instance.client;

// --- MODELS ---
class Post {
  final String id;
  final String? title;
  final String content;
  final String category;
  final String? subcategory;
  final DateTime createdAt;
  final int commentCount;
  final List<String> topics;

  Post({
    required this.id,
    this.title,
    required this.content,
    required this.category,
    this.subcategory,
    required this.createdAt,
    this.commentCount = 0,
    this.topics = const [],
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
      topics: json['topics'] != null ? List<String>.from(json['topics']) : [],
    );
  }
}


// --- PROVIDERS ---
final postsProvider = StreamProvider<List<Post>>((ref) {
  final stream = supabase
      .from('posts')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false);

  return stream.map((maps) => maps.map((json) => Post.fromJson(json)).toList());
});


// --- THEME ---
class AppTheme {
  static const primaryGreen = Color(0xFF10B981);
  static const darkBg = Color(0xFF0A0A0A);
  static const darkSurface = Color(0xFF1A1A1A);
  static const accentPurple = Color(0xFF8B5CF6);
  static const accentBlue = Color(0xFF3B82F6);
  static const accentOrange = Color(0xFFF59E0B);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    colorScheme: ColorScheme.dark(
      primary: primaryGreen,
      secondary: accentPurple,
      surface: darkSurface,
      background: darkBg,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

// --- MAIN ---
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  
  if (supabase.auth.currentUser == null) {
    await supabase.auth.signInAnonymously();
  }
  
  runApp(const ProviderScope(child: AgnonymousApp()));
}

class AgnonymousApp extends StatelessWidget {
  const AgnonymousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agnonymous',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// --- HOME SCREEN ---
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkBg,
              AppTheme.accentPurple.withOpacity(0.05),
              AppTheme.darkBg,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 280,
              floating: true,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: const Text(
                  'Agnonymous',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryGreen.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        '🌾',
                        style: TextStyle(fontSize: 64),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Truth in Agriculture',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Stats Row
            SliverToBoxAdapter(
              child: Container(
                height: 127,
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildStatCard('Active Users', '2.4K', '👥', AppTheme.primaryGreen),
                    _buildStatCard('Reports', '847', '📊', AppTheme.accentBlue),
                    _buildStatCard('Verified', '92%', '✓', AppTheme.accentOrange),
                  ],
                ),
              ),
            ),

            // Posts
            postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.primaryGreen.withOpacity(0.2),
                                  AppTheme.accentPurple.withOpacity(0.2),
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text('🌱', style: TextStyle(fontSize: 60)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No reports yet',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Be the first to share the truth',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => BeautifulPostCard(post: posts[index]),
                      childCount: posts.length,
                    ),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.black,
        icon: const Text('✍️', style: TextStyle(fontSize: 20)),
        label: const Text(
          'Share Truth',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String emoji, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              Icon(Icons.trending_up, color: color, size: 16),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- BEAUTIFUL POST CARD ---
class BeautifulPostCard extends StatelessWidget {
  final Post post;
  const BeautifulPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AgriculturalCategories.getCategoryById(post.category).color.withOpacity(0.1),
            AppTheme.darkSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AgriculturalCategories.getCategoryById(post.category).color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AgriculturalCategories.getCategoryById(post.category).color.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AgriculturalCategories.getCategoryById(post.category).color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(AgriculturalCategories.getCategoryById(post.category).icon, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Text(
                            AgriculturalCategories.getCategoryById(post.category).name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  timeago.format(post.createdAt),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.title != null) ...[
                  Text(
                    post.title!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  post.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                if (post.topics.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: post.topics.map((topic) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.accentBlue.withOpacity(0.3),
                            AppTheme.accentPurple.withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '#$topic',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ],
            ),
          ),


          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text('💬', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  '${post.commentCount} comments',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text('View Details'),
                      SizedBox(width: 4),
                      Text('→', style: TextStyle(fontSize: 18)),
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

  Color _getCategoryColor(String category) {
    final colors = {
      'Pesticide Use': const Color(0xFF10B981),
      'Water Issues': const Color(0xFF3B82F6),
      'Labor Conditions': const Color(0xFFF59E0B),
      'Environmental Impact': const Color(0xFF8B5CF6),
      'Animal Welfare': const Color(0xFFEF4444),
      'Other': const Color(0xFF6B7280),
    };
    return colors[category] ?? AppTheme.primaryGreen;
  }

  String _getCategoryEmoji(String category) {
    final emojis = {
      'Pesticide Use': '🧪',
      'Water Issues': '💧',
      'Labor Conditions': '👷',
      'Environmental Impact': '🌍',
      'Animal Welfare': '🐄',
      'Other': '📋',
    };
    return emojis[category] ?? '📋';
  }

}

// --- CREATE POST SCREEN ---
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagsController = TextEditingController();
  String _selectedCategory = 'livestock';
  bool _isSubmitting = false;

  Future<void> _submitPost() async {
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter content'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await supabase.from('posts').insert({
        'title': _titleController.text.isEmpty ? null : _titleController.text,
        'content': _contentController.text,
        'category': _selectedCategory,
        'topics': _tagsController.text.isEmpty ? [] : _tagsController.text.split(',').map((tag) => tag.trim()).toList(),
        'anonymous_user_id': supabase.auth.currentUser!.id,
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Truth shared! 🌟'),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: const Text('Share Truth'),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: _isSubmitting ? null : _submitPost,
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : const Text(
                      'Post',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryGreen.withOpacity(0.05),
              AppTheme.darkBg,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Share your observation',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your identity is protected',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),

              // Category
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              
              SimpleCategorySelector(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Title
              const Text(
                'Title (optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: _titleController,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Give your report a title...',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tags
              const Text(
                'Tags (optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: _tagsController,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'e.g., John Deere, drought, wheat prices, USDA',
                    hintStyle: TextStyle(color: Colors.white38),
                    helperText: 'Add specific companies, issues, or topics (comma separated)',
                    helperStyle: TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Content
              const Text(
                'Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 10,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Share what you observed...\n\nBe specific about:\n• What happened\n• When and where\n• Who was involved\n• Any evidence',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
}

// --- POST DETAIL SCREEN ---
class PostDetailScreen extends StatefulWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _commentController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    setState(() => _isSubmitting = true);

    try {
      await supabase.from('comments').insert({
        'post_id': widget.post.id,
        'content': _commentController.text,
        'anonymous_user_id': supabase.auth.currentUser!.id,
      });

      _commentController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Comment added! 💬'),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(
        title: const Text('Post Details'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.darkBg,
              AppTheme.accentPurple.withOpacity(0.05),
              AppTheme.darkBg,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: BeautifulPostCard(post: widget.post),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.darkSurface,
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.darkBg,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: TextField(
                        controller: _commentController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryGreen,
                          AppTheme.accentBlue,
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _isSubmitting ? null : _submitComment,
                      icon: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}