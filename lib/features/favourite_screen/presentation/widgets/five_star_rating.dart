import 'package:flutter/material.dart';

class FiveStarRating extends StatelessWidget {
  final double rating; // Current rating value from 0 to 5
  final int maxStars; // Maximum number of stars (usually 5)
  final double starSize; // Size of each star
  final Color filledStarColor; // Color of filled stars
  final Color unfilledStarColor; // Color of unfilled stars
  final Function(double)?
      onRatingUpdate; // Optional callback for interactive rating

  const FiveStarRating({
    super.key,
    this.rating = 0,
    this.maxStars = 5,
    this.starSize = 24.0,
    this.filledStarColor = Colors.amber,
    this.unfilledStarColor = Colors.grey,
    this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxStars, (index) {
        double starFill =
            index < rating ? 1 : (index < rating + 1 ? rating - index : 0);
        return GestureDetector(
          onTap: onRatingUpdate != null
              ? () => onRatingUpdate!(index + 1.0)
              : null,
          child: Icon(
            starFill == 1
                ? Icons.star // Fully filled star
                : starFill > 0
                    ? Icons.star_half // Half-filled star
                    : Icons.star_border, // Empty star
            color: starFill > 0 ? filledStarColor : unfilledStarColor,
            size: starSize,
          ),
        );
      }),
    );
  }
}
