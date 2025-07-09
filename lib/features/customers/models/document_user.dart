class DocumentUser {
  final int? id;
  final String? docName;
  final String? docDate;
  final String? docNumber;
  final String? docDesc;
  final String? imagePath;
  final String? docYear;
  final String? status;

  DocumentUser({
    this.id,
    this.docName,
    this.docDate,
    this.docNumber,
    this.docDesc,
    this.imagePath,
    this.docYear,
    this.status,
  });

  factory DocumentUser.fromMap(Map<String, dynamic> data) {
    return DocumentUser(
      id: data['id'],
      docName: data['doc_name'],
      docDate: data['doc_date'],
      docNumber: data['doc_number'],
      docDesc: data['doc_desc'],
      imagePath: data['image_path'],
      docYear: data['doc_year'],
      status: data['status']
    );
  }
}

// "id": 1,
//             "user_id": 6,
//             "doc_name": "testing upload",
//             "doc_date": "9-7-2025",
//             "doc_number": "324/22/INV/25",
//             "doc_desc": "tester upload",
//             "image_path": "/storage/uploads/IMG_1752071258_686e7c5a81e25.jpg",
//             "doc_year": "2025",
//             "status": "pending",
