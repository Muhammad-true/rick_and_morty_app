import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/models/character.dart';

class CharactercardWidgets extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final IconData icon;
  final VoidCallback onFavoriteToggle;
  final VoidCallback? onTap;
  const CharactercardWidgets({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.icon,
    required this.onFavoriteToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardRadius = 12.0;
    final theme = Theme.of(context);
    return Card(
      elevation: theme.cardTheme.elevation ?? 2.0,
      shape:
          theme.cardTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius),
          ),
      margin:
          theme.cardTheme.margin ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: theme.cardTheme.clipBehavior ?? Clip.antiAlias,
      color: theme.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(cardRadius),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(cardRadius),
                child: Image.file(
                  File(character.image),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: theme.dividerColor,
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: theme.disabledColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(character.name, style: theme.textTheme.titleLarge),
                    const SizedBox(height: 6),
                    Text(
                      '${character.status} • ${character.species}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    ...[
                      const SizedBox(height: 4),
                      Text(
                        'Локация: ${character.location}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                iconSize: 28,
                onPressed: onFavoriteToggle,
                icon: Icon(
                  isFavorite ? icon : Icons.star_border,
                  color:
                      isFavorite ? theme.primaryColor : theme.iconTheme.color,
                ),
                tooltip:
                    isFavorite
                        ? 'Удалить из избранного'
                        : 'Удалить из избранного',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
