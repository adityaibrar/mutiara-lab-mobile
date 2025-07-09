class AlbumDocument {
  final int? year;
  final String? totalDocument;

  AlbumDocument({this.year, this.totalDocument});

  factory AlbumDocument.fromMap(Map<String, dynamic> data) {
    return AlbumDocument(
      year: data['year'],
      totalDocument: data['total_document'],
    );
  }
}
