import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_app/core/theme/app_theme.dart';
import '../../domain/entities/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;
  final bool isFavorite;

  const ArticleCard({
    super.key,
    required this.article,
    this.onTap,
    this.onFavoritePressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;
    final radii = context.radii;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: spacing.md, vertical: spacing.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radii.md)),
      child: InkWell(
        borderRadius: BorderRadius.circular(radii.md),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (article.hasValidImage)
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radii.md),
                ),
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  height: 180,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.broken_image, size: 48),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onFavoritePressed != null)
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? colorScheme.error
                                : colorScheme.onSurfaceVariant,
                          ),
                          onPressed: onFavoritePressed,
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: spacing.sm),
                    child: Text(
                      article.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: spacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            article.sourceName,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        if (article.publishedAt != null)
                          Text(
                            article.publishedAt!
                                .toLocal()
                                .toString()
                                .split('.')
                                .first,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
