import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?>? pickImage()async{
    try{
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    }on PlatformException catch (error) {
      print('Failed to pick image : $error');
    }
  }
  static Future<List<File>?>? pickMultiImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images == null) return [];
      return images.map((xFileElement) => File(xFileElement.path)).toList();
    } on PlatformException catch (error) {
      print('Failed to pick image : $error');
    }
  }
}
