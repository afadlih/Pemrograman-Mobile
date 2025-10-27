import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
    this.imagePath,
  });

  final Color color;
  final VoidCallback? onFilterSelected;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: imagePath != null && !kIsWeb
                ? Image.file(
                    File(imagePath!),
                    fit: BoxFit.cover,
                    color: color.withOpacity(0.5),
                    colorBlendMode: BlendMode.hardLight,
                  )
                : Container(
                    color: color,
                    child: const Center(
                      child: Icon(Icons.photo, color: Colors.white54),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
