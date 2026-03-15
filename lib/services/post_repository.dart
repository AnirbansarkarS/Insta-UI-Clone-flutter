import '../models/post_model.dart';
import 'dart:math';

class PostRepository {
  Future<List<PostModel>> fetchPosts(int page, {int limit = 10}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(limit, (index) {
      int idx = (page * limit) + index;
      return PostModel(
        id: 'post_$idx',
        rootUser: 'user_$idx',
        rootUserAvatar: 'https://i.pravatar.cc/150?img=${idx % 70}',
        imageUrls: List.generate(Random().nextInt(3) + 1, (imgIdx) => 'https://picsum.photos/500/500?random=$idx$imgIdx'),
        caption: 'This is a demo caption for post $idx #flutter #clone',
      );
    });
  }
}
