import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/post_model.dart';
import '../providers/post_provider.dart';
import 'carousel_slider.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildMedia(),
        _buildActions(context),
        _buildCaption(),
        const Divider(),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(post.rootUserAvatar),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(post.rootUser, style: const TextStyle(fontWeight: FontWeight.bold))),
          const Icon(Icons.more_vert),
        ],
      ),
    );
  }

  Widget _buildMedia() {
    if (post.imageUrls.length > 1) {
      return PostCarouselSlider(imageUrls: post.imageUrls);
    }
    return InteractiveViewer( // Pinch-to-zoom
      child: CachedNetworkImage(
        imageUrl: post.imageUrls.first,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(height: 300, color: Colors.white),
        ),
        errorWidget: (context, url, error) => const SizedBox(height: 300, child: Icon(Icons.error)),
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(post.isLiked ? Icons.favorite : Icons.favorite_border,
                     color: post.isLiked ? Colors.red : null),
          onPressed: () {
            context.read<PostProvider>().toggleLike(post.id);
          },
        ),
        const IconButton(icon: Icon(Icons.comment_outlined), onPressed: null),
        const IconButton(icon: Icon(Icons.send_outlined), onPressed: null),
        const Spacer(),
        const IconButton(icon: Icon(Icons.bookmark_border), onPressed: null),
      ],
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(text: '${post.rootUser} ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: post.caption),
          ],
        ),
      ),
    );
  }
}
