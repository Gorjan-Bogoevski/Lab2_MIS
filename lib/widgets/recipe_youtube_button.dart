import 'package:flutter/material.dart';

class RecipeYoutubeLink extends StatelessWidget {
  final String? url;

  const RecipeYoutubeLink({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return SizedBox.shrink();
    }

    return Text("YouTube: $url");
  }
}