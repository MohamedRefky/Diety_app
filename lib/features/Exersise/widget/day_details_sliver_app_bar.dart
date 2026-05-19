import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../Core/utils/Colors.dart';

class DayDetailsSliverAppBar extends StatelessWidget {
  final String imageUrl;

  const DayDetailsSliverAppBar({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.background,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.button),
                ),
              ),
              errorWidget: (context, url, error) => Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Bottom gradient overlay for visual blend
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.background.withOpacity(0.6),
                    AppColors.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
