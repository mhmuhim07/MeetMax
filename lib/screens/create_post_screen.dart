import 'package:flutter/material.dart';
import 'package:meetmax/theme.dart';
import 'package:meetmax/widgets/primary_button.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: textColor),
        title: const Text('Create a post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {},
              child: const Row(
                children: [
                  Text('Visible for', style: TextStyle(color: darkGreyColor)),
                  SizedBox(width: 4),
                  Text('Friends'),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage:
                      NetworkImage('https://i.pravatar.cc/150?u=currentuser'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    maxLines: 8,
                    decoration: InputDecoration.collapsed(
                      hintText: 'What\'s happening?',
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam, color: Colors.red),
                    label: const Text('Live Video',
                        style: TextStyle(color: textColor)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.photo_library, color: Colors.green),
                    label: const Text('Photo/Video',
                        style: TextStyle(color: textColor)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.emoji_emotions, color: Colors.orange),
                    label: const Text('Feeling',
                        style: TextStyle(color: textColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Post',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
