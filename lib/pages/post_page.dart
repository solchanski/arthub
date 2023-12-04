import 'package:arthub/pages/widgets/post_card.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  final snap;
  const PostPage({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    return PostCard(snap: snap,);
  }
}