import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        _selectedImage = image;
        notifyListeners();
      } else if (option == 'camera') {
        image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        );
        _selectedImage = image;
        notifyListeners();
      }

      if (image != null) {
        _selectedImage = image;
        notifyListeners();
      }
    }
  }

  Future<void> deleteImage() async {
    _selectedImage = null;
    notifyListeners();
  }
}
