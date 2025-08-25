class Post {
  final String id;
  final String authorName;
  final String authorImageUrl;
  final String timeAgo;
  final String content;
  final String imageUrl;
  int likes;
  List<String> comments;
  bool isLiked;

  Post({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.content,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });
}
