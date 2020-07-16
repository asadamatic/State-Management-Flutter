import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {

  Future<File> imagePicker({@required ImageSource source}) async{

    return ImagePicker.pickImage(source: source);
  }
}