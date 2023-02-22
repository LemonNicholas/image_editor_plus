import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_size_getter/image_size_getter.dart';

class ImageItem {
  String? key;
  int width = 300;
  int height = 300;
  Uint8List image = Uint8List.fromList([]);
  double viewportRatio = 1;
  Completer loader = Completer();

  ImageItem({dynamic img, this.key}) {
    if (img != null) load(img);
  }

  Future get status => loader.future;

  Future load(dynamic imageFile) async {
    loader = Completer();

    dynamic decodedImage;
    Size? size;

    if (imageFile is ImageItem) {
      height = imageFile.height;
      width = imageFile.width;

      image = imageFile.image;
      viewportRatio = imageFile.viewportRatio;

      loader.complete(true);
    } else if (imageFile is File || imageFile is XFile) {
      image = await imageFile.readAsBytes();
      size = ImageSizeGetter.getSize(MemoryInput(image));
      // decodedImage = await decodeImageFromList(image);
    } else {
      image = imageFile;
      size = ImageSizeGetter.getSize(MemoryInput(image));
      // decodedImage = await decodeImageFromList(imageFile);
    }

    // image was decoded
    if (size != null) {
      // print(['height', viewportSize.height, decodedImage.height]);
      // print(['width', viewportSize.width, decodedImage.width]);

      height = size.height;
      width = size.width;
      viewportRatio = viewportSize.height / height;

      loader.complete(decodedImage);
    }
    print("lemon width : $width");
    print("lemon height : $height");
    print("lemon viewportRatio : $viewportRatio");

    return true;
  }
}
