import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:uniten_alumni_app/helper/web_file_picker.dart' if (dart.library.io) 'package:uniten_alumni_app/native_file_picker.dart';

class ImagePickerHelper {
  static Future<Object?> pickImage() async {
    if (kIsWeb) {
      // Web
      return await WebFilePicker.pickImage();
    } else {
      // Mobile
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        return io.File(pickedImage.path); // Return the picked image file
      }
      return null;
    }
  }
}

