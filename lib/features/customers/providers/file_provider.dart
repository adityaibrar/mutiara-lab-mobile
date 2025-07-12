import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:pdfx/pdfx.dart';

import '../../../widgets/custom_snackbar.dart';

class FileNotifier extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();

  XFile? _selectedImage;
  XFile? get selectedImage => _selectedImage;

  File? _selectedPdf;
  File? get selectedPdf => _selectedPdf;

  // === PILIH FILE (Camera, Galeri, Dokumen) ===
  Future<void> selectFile(BuildContext context) async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Sumber File'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Galeri'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Dokumen (PDF)'),
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
          ],
        ),
      ),
    );

    if (option == null) return;

    if (option == 'camera' || option == 'gallery') {
      // === PILIH GAMBAR ===
      XFile? image;
      if (option == 'camera') {
        image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        );
      } else {
        image = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
      }

      if (image != null) {
        final text = await _runOCR(image);
        if (text.toLowerCase().contains('mutiara')) {
          _selectedImage = image;
          _selectedPdf = null; // reset PDF jika sebelumnya terisi
          notifyListeners();
        } else {
          CustomSnackbar(
            title: 'Gagal',
            message: 'Gambar invalid...',
            type: SnackbarType.error,
          ).show(context);
          _selectedImage = null;
          notifyListeners();
        }
      }
    } else if (option == 'pdf') {
      // === PILIH PDF ===
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        File pdfFile = File(result.files.single.path!);

        bool hasMutiara = await _runOcrOnPdf(pdfFile);
        if (hasMutiara) {
          _selectedPdf = pdfFile;
          _selectedImage = null; // reset gambar jika sebelumnya terisi
        } else {
          CustomSnackbar(
            title: 'Gagal',
            message: 'Dokumen invalid...',
            type: SnackbarType.error,
          ).show(context);
          _selectedPdf = null;
        }
        notifyListeners();
      }
    }
  }

  // === OCR GAMBAR ===
  Future<String> _runOCR(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    return recognizedText.text;
  }

  // === OCR PDF ===
  Future<bool> _runOcrOnPdf(File pdfFile) async {
    final doc = await PdfDocument.openFile(pdfFile.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    bool found = false;

    try {
      for (int i = 1; i <= doc.pagesCount; i++) {
        final page = await doc.getPage(i);
        final pageImage = await page.render(
          width: page.width,
          height: page.height,
          format: PdfPageImageFormat.png,
        );

        final bytes = pageImage!.bytes;

        final tempFile = File('${Directory.systemTemp.path}/temp_page.png');
        await tempFile.writeAsBytes(bytes);

        final inputImage = InputImage.fromFilePath(tempFile.path);
        final recognizedText = await textRecognizer.processImage(inputImage);

        await page.close(); // ✅ TUTUP PAGE SAAT ITU JUGA

        if (recognizedText.text.toLowerCase().contains('mutiara')) {
          found = true;
          break; // ✅ keluar loop, tutup doc di finally
        }
      }
    } finally {
      await textRecognizer.close();
      await doc.close(); // ✅ Tutup dokumen sekali saja di akhir
    }

    return found;
  }

  // === RESET ===
  Future<void> deleteFile() async {
    _selectedImage = null;
    _selectedPdf = null;
    notifyListeners();
  }
}
