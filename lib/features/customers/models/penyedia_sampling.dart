class PenyediaSampling {
  final int id;
  final String status;
  final String tglSruvey;
  final String documentPath;

  PenyediaSampling({
    required this.id,
    required this.status,
    required this.tglSruvey,
    required this.documentPath,
  });

  factory PenyediaSampling.fromMap(Map<String, dynamic> data) {
    return PenyediaSampling(
      id: data['id'],
      status: data['status'],
      tglSruvey: data['tgl_survey'],
      documentPath: data['document_path'],
    );
  }
}
