import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widgets/custom_snackbar.dart';

class ImageNotifier extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  XFile? _selectedImage;
  XFile? get selectedImage => _selectedImage;

  Future<void> selectImage(BuildContext context) async {
    final option = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pilih Sumber Gambar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Galeri'),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Kamera'),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
          ],
        ),
      ),
    );

    if (option != null) {
      XFile? image;
      if (option == 'gallery') {
        image = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
      } else if (option == 'camera') {
        image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        );
      }

      if (image != null) {
        // Jalankan OCR
        final text = await _runOCR(image);
        if (text.toLowerCase().contains('mutiara')) {
          _selectedImage = image;
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
    }
  }

  Future<String> _runOCR(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(
      inputImage,
    );
    await textRecognizer.close();

    return recognizedText.text; // hasil semua teks
  }

  Future<void> deleteImage() async {
    _selectedImage = null;
    notifyListeners();
  }
}
