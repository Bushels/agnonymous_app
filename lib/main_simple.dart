import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

// --- 1. SUPABASE CONFIGURATION ---
const String supabaseUrl = 'https://ibgsloyjxdopkvwqcqwh.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImliZ3Nsb3lqeGRvcGt2d3FjcXdoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2ODYzMzksImV4cCI6MjA2ODI2MjMzOX0.Ik1980vz4s_UxVuEfBm61-kcIzEH-Nt-hQtydZUeNTw';

final supabase = Supabase.instance.client;

// --- DATA MODELS ---
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

// --- 2. STATE MANAGEMENT (RIVERPOD PROVIDERS) ---
final postsProvider = StreamProvider<List<Post>>((ref) {
  final stream = supabase
      .from('posts')
      .stream(primaryKey: ['id'])
      .order('created_at', ascending: false);

  return stream.map((maps) => maps.map((json) => Post.fromJson(json)).toList());
});

// --- 3. MAIN APP SETUP ---
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  
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
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// --- 4. HOME SCREEN ---
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agnonymous'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePostScreen()),
              );
            },
          ),
        ],
      ),
      body: postsAsync.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.article_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No posts yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Be the first to share a report!',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: posts.length,
            itemBuilder: (context, index) => PostCard(post: posts[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

// --- 5. CREATE POST SCREEN ---
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'Pesticide Use';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Pesticide Use',
    'Water Issues',
    'Labor Conditions',
    'Environmental Impact',
    'Animal Welfare',
    'Other',
  ];

  Future<void> _submitPost() async {
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some content')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await supabase.from('posts').insert({
        'title': _titleController.text.isEmpty ? null : _titleController.text,
        'content': _contentController.text,
        'category': _selectedCategory,
        'anonymous_user_id': supabase.auth.currentUser!.id,
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submitPost,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Category *', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Title (optional)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Give your post a title...',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Content *', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Share what you\'ve observed...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

// --- 6. POST CARD WIDGET ---
class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    post.category,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  timeago.format(post.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
            if (post.title != null && post.title!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                post.title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              post.content,
              style: const TextStyle(height: 1.5),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.chat_bubble_outline, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text(
                  '${post.commentCount} comments',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}