class ImagePathExtractor {
 static List<String> extractProductImagePaths(List<dynamic> fullUrls) {
    if (fullUrls.isEmpty) return [];

    List<String> extractedPaths = [];

    final RegExp pattern = RegExp(
      r'product\.images\.\d+\/[^\/\s]+\.[a-zA-Z0-9]+$',
      caseSensitive: false,
    );

    for (String url in fullUrls) {
      if (url.trim().isEmpty) continue;

      try {
        final match = pattern.firstMatch(url);
        if (match != null) {
          String extractedPath = match.group(0)!;
          if (!extractedPaths.contains(extractedPath)) {
            extractedPaths.add(extractedPath);
          }
        }
      } catch (e) {
        
        continue;
      }
    }

    return extractedPaths;
  }

  String? extractSingleProductImagePath(String fullUrl) {
    List<String> result = extractProductImagePaths([fullUrl]);
    return result.isNotEmpty ? result.first : null;
  }
}