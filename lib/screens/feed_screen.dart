import 'package:flutter/material.dart';
import 'package:meetmax/widgets/home_app_bar.dart';
import 'package:meetmax/widgets/story_circle.dart';
import 'package:provider/provider.dart';
import 'package:meetmax/screens/create_post_screen.dart';
import 'package:meetmax/viewmodels/auth_view_model.dart';
import 'package:meetmax/viewmodels/feed_view_model.dart';
import 'package:meetmax/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.watch<FeedViewModel>();

    return Scaffold(
      appBar: HomeAppBar(
        userImageUrl: 'https://i.pravatar.cc/150?u=currentuser',
        onAvatarTap: () => context.read<AuthViewModel>().logout(),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<FeedViewModel>().fetchPosts(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Stories Section
              SizedBox(
                height: 105,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  itemCount: feedViewModel.stories.length,
                  itemBuilder: (context, index) {
                    final story = feedViewModel.stories[index];
                    return SizedBox(
                      width: 80,
                      child: StoryCircle(
                        imageUrl: story['imageUrl']!,
                        name: story['name']!,
                        isCurrentUser: index == 0,
                      ),
                    );
                  },
                ),
              ),
              // Create Post
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const CreatePostScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Text('What\'s on your mind?',
                            style: TextStyle(color: Colors.grey)),
                        Spacer(),
                        Icon(Icons.photo_library, color: Colors.green),
                      ],
                    ),
                  ),
                ),
              ),
              // Posts List
              if (feedViewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: feedViewModel.posts.length,
                  itemBuilder: (context, index) {
                    final post = feedViewModel.posts[index];
                    return PostCard(post: post);
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Community'),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: 'Notification'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
