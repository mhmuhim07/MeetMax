import 'package:flutter/material.dart';
import 'package:meetmax/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommentTile extends StatelessWidget {
  final String authorName;
  final String authorImageUrl;
  final String timeAgo;
  final String commentText;
  final bool isReply;

  const CommentTile({
    super.key,
    required this.authorName,
    required this.authorImageUrl,
    required this.timeAgo,
    required this.commentText,
    this.isReply = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isReply ? 40.0 : 0.0, top: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(authorImageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(authorName,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(commentText),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(timeAgo,
                        style: const TextStyle(
                            fontSize: 12, color: darkGreyColor)),
                    const SizedBox(width: 12),
                    const Text('Like',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: darkGreyColor)),
                    const SizedBox(width: 12),
                    const Text('Reply',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: darkGreyColor)),
                  ],
                )
              ],
            ),
          ),
          const Icon(Icons.more_horiz, color: darkGreyColor),
        ],
      ),
    );
  }
}
