import 'package:flutter/material.dart';
import 'package:meetmax/api/mock_api.dart';
import 'package:meetmax/models/post_model.dart';

class FeedViewModel extends ChangeNotifier {
  final MockApi _api = MockApi();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  List<Map<String, String>> _stories = [];
  List<Map<String, String>> get stories => _stories;

  FeedViewModel() {
    fetchPosts();
    fetchStories();
  }
  Future<void> fetchStories() async {
    _isLoading = true;
    notifyListeners();

    _stories = await _api.fetchStories();

    // No need to set isLoading to false here, as fetchPosts will do it
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    _posts = await _api.fetchPosts();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> togglePostLike(String postId) async {
    await _api.togglePostLike(postId);
    // Notify the UI to rebuild and show the updated like status
    notifyListeners();
  }

  Future<void> addComment(String postId, String comment) async {
    await _api.addComment(postId, comment);
    // Notify the UI to rebuild and show the new comment
    notifyListeners();
  }
}
