import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meetmax/models/post_model.dart';
import 'package:meetmax/theme.dart';
import 'package:meetmax/viewmodels/feed_view_model.dart';
import 'package:meetmax/widgets/comment_tile.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(widget.post.authorImageUrl)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.post.authorName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("${widget.post.timeAgo} · Public",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 16),
            Text(widget.post.content),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.post.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  height: 200,
                  color: Colors.grey[200],
                ),
                errorWidget: (context, url, error) => Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.favorite, size: 16, color: primaryColor),
                const SizedBox(width: 4),
                Text('${widget.post.likes} Likes',
                    style: const TextStyle(color: darkGreyColor, fontSize: 12)),
                const Spacer(),
                Text('${widget.post.comments.length} Comments',
                    style: const TextStyle(color: darkGreyColor, fontSize: 12)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context: context,
                  icon: widget.post.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  label: 'Like',
                  color: widget.post.isLiked ? primaryColor : darkGreyColor,
                  onTap: () => feedViewModel.togglePostLike(widget.post.id),
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.chat_bubble_outline,
                  label: 'Comments',
                  color: darkGreyColor,
                  onTap: () {},
                ),
                _buildActionButton(
                  context: context,
                  icon: Icons.share_outlined,
                  label: 'Share',
                  color: darkGreyColor,
                  onTap: () {},
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        NetworkImage('https://i.pravatar.cc/150?u=currentuser'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        filled: true,
                        fillColor: greyColor,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.gif_box_outlined, color: darkGreyColor),
                            SizedBox(width: 8),
                            Icon(Icons.photo_camera_outlined,
                                color: darkGreyColor),
                            SizedBox(width: 8),
                            Icon(Icons.emoji_emotions_outlined,
                                color: darkGreyColor),
                            SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_outlined, color: primaryColor),
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        feedViewModel.addComment(
                            widget.post.id, _commentController.text);
                        _commentController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.post.comments.length,
              itemBuilder: (context, index) {
                return CommentTile(
                  authorName: 'Swapan Bala',
                  authorImageUrl: 'https://i.pravatar.cc/150?u=swapan',
                  timeAgo: '9h ago',
                  commentText: widget.post.comments[index],
                );
              },
            ),
            if (widget.post.comments.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('See 1 more comment',
                    style: TextStyle(
                        color: darkGreyColor, fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
