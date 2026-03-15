import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

class PostProvider with ChangeNotifier {
  final PostRepository _repository = PostRepository();

  List<PostModel> _posts = [];
  bool _isLoading = false;
  int _currentPage = 0;
  bool _hasMore = true;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  PostProvider() {
    fetchNextPosts();
  }

  Future<void> fetchNextPosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newPosts = await _repository.fetchPosts(_currentPage);
      
      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        _posts.addAll(newPosts);
        _currentPage++;
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLike(String postId) {
    final idx = _posts.indexWhere((p) => p.id == postId);
    if (idx != -1) {
      _posts[idx].isLiked = !_posts[idx].isLiked;
      notifyListeners();
    }
  }
}
