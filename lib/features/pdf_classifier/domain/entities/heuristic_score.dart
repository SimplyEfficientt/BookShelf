import 'book_category.dart';

/// Heuristic evaluation result containing category assignment and confidence metrics.
class HeuristicScore {
  final BookCategory category;
  final double confidenceScore; // Range: 0.0 (Uncertain) to 1.0 (High Certainty)
  final double textDensityRatio;
  final double imageDensityRatio;
  final List<String> matchedStructuralKeywords;
  final String reasoningSummary;

  const HeuristicScore({
    required this.category,
    required this.confidenceScore,
    required this.textDensityRatio,
    required this.imageDensityRatio,
    required this.matchedStructuralKeywords,
    required this.reasoningSummary,
  });

  @override
  String toString() {
    return 'HeuristicScore(category: ${category.displayName}, confidence: ${(confidenceScore * 100).toStringAsFixed(1)}%, reason: $reasoningSummary)';
  }
}
