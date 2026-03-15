import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String username;
  final String imageUrl;

  const StoryItem({Key? key, required this.username, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.orange],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(username, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
