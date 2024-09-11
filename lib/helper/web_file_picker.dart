import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

class WebFilePicker {
  static Future<Uint8List?> pickImage() async {
    final fileInput = html.FileUploadInputElement();
    fileInput.accept = 'image/*';
    final completer = Completer<Uint8List?>();

    fileInput.onChange.listen((e) async {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(fileInput.files![0]);

      reader.onLoadEnd.listen((e) {
        completer.complete(reader.result as Uint8List);
      });
    });

    fileInput.click();
    return completer.future;
  }
}
