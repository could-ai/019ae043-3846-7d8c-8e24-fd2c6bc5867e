import 'package:flutter/material.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data
  final List<Post> _posts = [
    Post(
      id: '1',
      authorName: 'Alice Johnson',
      authorHandle: 'alice_j',
      content: 'Just joined MediaWall! Excited to connect with everyone here. #NewBeginnings',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      likes: 12,
      comments: 2,
    ),
    Post(
      id: '2',
      authorName: 'Bob Smith',
      authorHandle: 'bob_builder',
      content: 'Flutter is amazing for building cross-platform apps. The hot reload feature is a lifesaver!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 45,
      comments: 8,
      reposts: 5,
    ),
    Post(
      id: '3',
      authorName: 'Charlie Brown',
      authorHandle: 'charlie_b',
      content: 'Does anyone know a good place for coffee downtown? Need recommendations.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      likes: 3,
      comments: 15,
    ),
  ];

  void _addNewPost(String content) {
    setState(() {
      _posts.insert(
        0,
        Post(
          id: DateTime.now().toString(),
          authorName: 'Current User',
          authorHandle: 'me',
          content: content,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _toggleLike(int index) {
    setState(() {
      final post = _posts[index];
      if (post.isLiked) {
        post.likes--;
        post.isLiked = false;
      } else {
        post.likes++;
        post.isLiked = true;
      }
    });
  }

  void _toggleRepost(int index) {
    setState(() {
      final post = _posts[index];
      if (post.isReposted) {
        post.reposts--;
        post.isReposted = false;
      } else {
        post.reposts++;
        post.isReposted = true;
      }
    });
  }

  void _showCommentDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comments'),
        content: const Text('Comments feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog() {
    final textController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'New Post',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: textController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What\'s happening?',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  _addNewPost(textController.text);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Post'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MediaWall', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple.shade50,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return PostCard(
            post: _posts[index],
            onLike: () => _toggleLike(index),
            onComment: () => _showCommentDialog(index),
            onRepost: () => _toggleRepost(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostDialog,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
