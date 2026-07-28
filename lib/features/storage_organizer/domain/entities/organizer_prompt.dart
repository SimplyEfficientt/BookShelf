import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';

/// Modal model representing a suggestion to organize an imported PDF into a categorized directory.
class FileOrganizerPrompt {
  final String sourceFilePath;
  final String fileName;
  final BookCategory category;
  final String suggestedDirectoryPath;
  final String suggestedVirtualShelf;

  const FileOrganizerPrompt({
    required this.sourceFilePath,
    required this.fileName,
    required this.category,
    required this.suggestedDirectoryPath,
    required this.suggestedVirtualShelf,
  });

  @override
  String toString() {
    return 'FileOrganizerPrompt(file: $fileName, category: ${category.displayName}, targetDir: $suggestedDirectoryPath)';
  }
}
