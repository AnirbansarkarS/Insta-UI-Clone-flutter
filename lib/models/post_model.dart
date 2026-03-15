class PostModel {
  final String id;
  final String rootUser;
  final String rootUserAvatar;
  final List<String> imageUrls;
  final String caption;
  bool isLiked;

  PostModel({
    required this.id,
    required this.rootUser,
    required this.rootUserAvatar,
    required this.imageUrls,
    required this.caption,
    this.isLiked = false,
  });
}
