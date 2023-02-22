import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor_plus/data/image_item.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ImageEditorExample(),
    ),
  );
}

class ImageEditorExample extends StatefulWidget {
  const ImageEditorExample({
    Key? key,
  }) : super(key: key);

  @override
  _ImageEditorExampleState createState() => _ImageEditorExampleState();
}

class _ImageEditorExampleState extends State<ImageEditorExample> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    loadAsset("image.jpg");
  }

  void loadAsset(String name) async {
    var data = await rootBundle.load('assets/$name');
    setState(() => imageData = data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ImageEditor Example"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageData != null) Image.memory(imageData!),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Single image editor"),
            onPressed: () async {
              List<ImageItem>? editedImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageEditor(
                    images: [ImageItem(img: imageData,key: "testing1")],
                  ),
                ),
              );

              print("lemon single editedImage : ${editedImage}");
              if(editedImage?.isNotEmpty == true){
                print("lemon single editedImage.length : ${editedImage?.length}");
                editedImage?.forEach((element) {
                  print("lemon single element : ${element.key}");
                });
              }
              // // replace with edited image
              // if (editedImage != null) {
              //   imageData = editedImage;
              //   setState(() {});
              // }
            },
          ),
          ElevatedButton(
            child: const Text("Multiple image editor"),
            onPressed: () async {
              List<ImageItem>? editedImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageEditor(
                    images: [
                      ImageItem(img: imageData,key: "testing2"),
                      ImageItem(img: imageData,key: "testing3"),
                    ],
                    allowCamera: true,
                    allowGallery: true,
                  ),
                ),
              );

              print("lemon multiple editedImage : ${editedImage}");
              if(editedImage?.isNotEmpty == true){
                print("lemon multiple editedImage.length : ${editedImage?.length}");
                editedImage?.forEach((element) {
                  print("lemon multiple element : ${element.key}");
                });
              }

              // // replace with edited image
              // if (editedImage != null) {
              //   imageData = editedImage;
              //   setState(() {});
              // }
            },
          ),
        ],
      ),
    );
  }
}
