import 'dart:io';
import 'package:bookshelf/features/pdf_classifier/domain/entities/book_category.dart';
import '../domain/entities/organizer_prompt.dart';

/// Storage Directory Manager handling physical folder organization and virtual shelf tagging.
class StorageDirectoryOrganizerService {
  final String baseStorageRoot;

  StorageDirectoryOrganizerService({this.baseStorageRoot = '/storage/emulated/0/BookShelf'});

  /// Generates a non-intrusive prompt suggesting physical directory placement based on category.
  FileOrganizerPrompt generateOrganizationPrompt({
    required String sourceFilePath,
    required BookCategory category,
  }) {
    final fileName = sourceFilePath.split('/').last.split('\\').last;
    final targetFolder = '$baseStorageRoot/${category.defaultFolder}';

    return FileOrganizerPrompt(
      sourceFilePath: sourceFilePath,
      fileName: fileName,
      category: category,
      suggestedDirectoryPath: targetFolder,
      suggestedVirtualShelf: category.displayName,
    );
  }

  /// Executes physical file move/copy operation to the target categorized directory.
  Future<File> moveFileToCategorizedDirectory({
    required String sourcePath,
    required String targetDirectoryPath,
  }) async {
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      throw Exception('Source PDF file does not exist at $sourcePath');
    }

    final targetDir = Directory(targetDirectoryPath);
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final fileName = sourcePath.split('/').last.split('\\').last;
    final destinationPath = '${targetDir.path}/$fileName';

    // Move file (copy + delete fallback for cross-filesystem compatibility)
    try {
      return await sourceFile.rename(destinationPath);
    } catch (_) {
      final copiedFile = await sourceFile.copy(destinationPath);
      await sourceFile.delete();
      return copiedFile;
    }
  }
}
