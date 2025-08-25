import 'package:flutter/material.dart';
import 'package:meetmax/theme.dart';

class StoryCircle extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isCurrentUser;

  const StoryCircle({
    super.key,
    required this.imageUrl,
    required this.name,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(imageUrl),
            ),
            if (isCurrentUser)
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
