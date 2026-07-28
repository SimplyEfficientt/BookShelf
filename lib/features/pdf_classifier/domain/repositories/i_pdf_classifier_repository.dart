import 'dart:typed_data';
import '../entities/book_category.dart';
import '../entities/heuristic_score.dart';
import '../entities/pdf_metadata.dart';

/// Contract for PDF parsing, text extraction, and heuristic classification repository.
abstract class IPdfClassifierRepository {
  /// Extracts structural metadata from the PDF file.
  Future<PdfMetadata> extractPdfMetadata(String filePath);

  /// Performs local heuristic classification based on PDF page metrics.
  Future<HeuristicScore> classifyPdf(PdfMetadata metadata);

  /// Extracts Page 1 of the PDF as a cover thumbnail byte stream.
  Future<Uint8List?> renderPageOneCoverThumbnail(String filePath);
}
