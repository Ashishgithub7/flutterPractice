import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onPictureTake});

  void Function(File image) onPictureTake;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
     if(pickedImage == null) return;
     setState(() {
       selectedImage = File(pickedImage.path);
     });
     widget.onPictureTake(selectedImage!);
    }

  
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        label: Text("Take a picture"),
        icon: Icon(Icons.camera),
      );

    if(selectedImage!=null){
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          selectedImage!, 
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withAlpha(120),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: content,
    );
  }
}
