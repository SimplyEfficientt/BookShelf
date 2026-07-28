import 'dart:typed_data';

/// Immutable metadata extracted directly from a local PDF document.
class PdfMetadata {
  final String filePath;
  final String fileName;
  final int totalPages;
  final String? title;
  final String? author;
  final String? creator;
  final String? producer;
  final String? creationDate;
  final bool isEncrypted;
  final int totalCharacterCount;
  final double averageCharsPerPage;
  final Uint8List? fallbackCoverThumbnail;
  final List<String> detectedKeywords;

  const PdfMetadata({
    required this.filePath,
    required this.fileName,
    required this.totalPages,
    this.title,
    this.author,
    this.creator,
    this.producer,
    this.creationDate,
    required this.isEncrypted,
    required this.totalCharacterCount,
    required this.averageCharsPerPage,
    this.fallbackCoverThumbnail,
    required this.detectedKeywords,
  });

  @override
  String toString() {
    return 'PdfMetadata(fileName: $fileName, totalPages: $totalPages, avgCharsPerPage: ${averageCharsPerPage.toStringAsFixed(1)}, keywords: $detectedKeywords)';
  }
}
