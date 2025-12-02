class Post {
  final String id;
  final String authorName;
  final String authorHandle;
  final String content;
  final DateTime timestamp;
  int likes;
  int comments;
  int reposts;
  bool isLiked;
  bool isReposted;

  Post({
    required this.id,
    required this.authorName,
    required this.authorHandle,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.comments = 0,
    this.reposts = 0,
    this.isLiked = false,
    this.isReposted = false,
  });
}
