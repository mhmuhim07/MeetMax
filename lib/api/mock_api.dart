import 'package:bcrypt/bcrypt.dart';
import 'package:meetmax/models/post_model.dart';
import 'package:meetmax/models/user_model.dart';

class MockApi {
  static final MockApi _instance = MockApi._internal();
  factory MockApi() {
    return _instance;
  }
  MockApi._internal();

  final List<User> _users = [
    User(
      name: 'Mudabbir',
      email: 'test@gmail.com',
      password: '123456',
      birthDate: '01/01/2000',
      isHashed: false,
    )
  ];
  final List<Post> _posts = [
    Post(
        id: '1',
        authorName: 'Sandro',
        authorImageUrl: 'https://i.pravatar.cc/150?u=sandro',
        timeAgo: '5m ago',
        content:
            'Exploring the beautiful Alps today! The scenery is just breathtaking. 🏔️',
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        likes: 1024,
        comments: ['Wow!', 'Amazing shot!']),
    Post(
        id: '2',
        authorName: 'Edison',
        authorImageUrl: 'https://i.pravatar.cc/150?u=edison',
        timeAgo: '1h ago',
        content:
            'Just finished a great book. Any recommendations for what to read next?',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-MSHDeRRp2m86wMKYkqx88spBZvID-b4g2A&s',
        likes: 48,
        comments: ['Wow!', 'How was the book?']),
  ];

  final List<Map<String, String>> _stories = [
    {'name': 'Mudabbir', 'imageUrl': 'https://i.pravatar.cc/150?u=currentuser'},
    {'name': 'Edilson', 'imageUrl': 'https://i.pravatar.cc/150?u=story1'},
    {'name': 'Arlene', 'imageUrl': 'https://i.pravatar.cc/150?u=story2'},
    {'name': 'John', 'imageUrl': 'https://i.pravatar.cc/150?u=story3'},
    {'name': 'Jane', 'imageUrl': 'https://i.pravatar.cc/150?u=story4'},
    {'name': 'Mike', 'imageUrl': 'https://i.pravatar.cc/150?u=story5'},
  ];
  Future<List<Map<String, String>>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _stories;
  }

  Future<String> registerUser(User userWithPlainTextPassword) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.any((u) => u.email == userWithPlainTextPassword.email)) {
      return 'Error: Email already exists.';
    }

    // 1. Hash the plain text password from the incoming user object
    final String hashedPassword =
        BCrypt.hashpw(userWithPlainTextPassword.password, BCrypt.gensalt());

    // 2. Create a new User object with the hashed password to store
    final secureUser = User(
        name: userWithPlainTextPassword.name,
        email: userWithPlainTextPassword.email,
        password: hashedPassword, // Store the hash in the password field
        birthDate: userWithPlainTextPassword.birthDate,
        isHashed: true);

    _users.add(secureUser);
    return 'Success';
  }

  // --- UPDATED loginUser function ---
  Future<String> loginUser(String email, String plainTextPassword) async {
    await Future.delayed(const Duration(seconds: 1));

    // 1. Find the user by email
    final user = _users.where((u) => u.email == email);

    if (user.isEmpty) {
      return 'Error: Invalid credentials.'; // User not found
    }

    // 2. Securely check the incoming plain text password against the stored hash
    if (user.first.isHashed) {
      // If the password IS hashed, use bcrypt to check
      if (BCrypt.checkpw(plainTextPassword, user.first.password)) {
        return 'Success';
      }
    } else {
      // If the password IS NOT hashed, it's an old user.
      // 3. First, check against the old plain-text password.
      if (user.first.password == plainTextPassword) {
        // 4. If it matches, HASH the password they just gave us.
        final String newHashedPassword =
            BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());

        // 5. Update the user's record in the "database"
        user.first.password = newHashedPassword;
        user.first.isHashed = true;

        return 'Success'; // Log them in successfully
      }
    }

    return 'Error: Invalid credentials.';
  }

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _posts;
  }

  Future<void> togglePostLike(String postId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final post = _posts.firstWhere((p) => p.id == postId);
    post.isLiked = !post.isLiked;
    if (post.isLiked) {
      post.likes++;
    } else {
      post.likes--;
    }
  }

  // Add this new method to add a comment
  Future<void> addComment(String postId, String comment) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final post = _posts.firstWhere((p) => p.id == postId);
    post.comments.add(comment);
  }
}
