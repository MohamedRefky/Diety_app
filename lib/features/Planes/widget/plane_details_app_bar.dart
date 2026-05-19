import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlaneDetailsAppBar extends StatelessWidget {
  final String image;
  final bool showAppBarTitle;

  const PlaneDetailsAppBar({
    Key? key,
    required this.image,
    required this.showAppBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(3, 11, 24, 1.0),
      title: showAppBarTitle
          ? const Text(
              "Plans Details",
              style: TextStyle(color: Colors.white),
            )
          : null,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      expandedHeight: 250.0,
      elevation: 0,
      pinned: true,
      floating: false,
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'planImage$image',
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            imageUrl: image,
          ),
        ),
      ),
    );
  }
}
