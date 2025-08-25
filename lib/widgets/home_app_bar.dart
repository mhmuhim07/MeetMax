import 'package:flutter/material.dart';
import 'package:meetmax/theme.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userImageUrl;
  final VoidCallback? onAvatarTap;

  const HomeAppBar({
    super.key,
    required this.userImageUrl,
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onAvatarTap,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
          ),
        ),
      ),
      title: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for something...',
            prefixIcon: const Icon(Icons.search, size: 20),
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: greyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chat_bubble_outline, color: darkGreyColor),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
