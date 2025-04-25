import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static Future<File?> imageSelector({ImageSource? image}) async {
    XFile? images = await ImagePicker().pickImage(
      source: image!,
      imageQuality: 60,
      maxWidth: 800,
      maxHeight: 600,
    );
    // XFile? images = await ImagePicker().pickVideo(
    //   source: image!,
    // );

    if (images != null) {
      // final File imageFile = File(images.path);

      // int sizeInBytes = await imageFile.length();

      // double sizeInKB = sizeInBytes / 1024;
      // double sizeInMB = sizeInKB / 1024;
      // log('Size: $sizeInMB MB');
      // log('Size: $sizeInKB KB');
      // log('Size: $sizeInBytes Bytes');

      return File(images.path);
    }

    return null;
  }
   static Future<List<File>?> selectMedia() async {
    List<File> selectedImages = [];
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultipleMedia(
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 600,
    );

    for (XFile image in images) {
      selectedImages.add(File(image.path));
    }
    return selectedImages;
  }

//   static Future<List<File?> imageSelector({ImageSource? image}) async {
//         final picker = ImagePicker();
//   List<File> selectedImages = [];
//     List<File?> images = await picker.pickMultiImage(
//       imageQuality: 60,
//       maxWidth: 800,
//       maxHeight: 600,
//     );

//     for (XFile image in images) {
//       selectedImages.add(File(image.path));
//   }

// }
}

Future<Uint8List?> testCompressFile(File file) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 94,
    rotate: 90,
  );

  return result;
}

class ImageHelper {
  List<File> selectedImages = [];

  Future<void> addImages() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultipleMedia(
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 600,
    );

    for (XFile image in images) {
      selectedImages.add(File(image.path));
    }
  }
}

class SelectMediaFromStorage {
  static Future<List<PlatformFile>?> selectMedia() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,

      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );
    if (res != null) {
      return res.files;
    }
    return null;
  }
}

// Future<void> getMedia() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.getMedia(source: ImageSource.gallery);

//   setState(() {
//     if (pickedFile != null) {
//       if (pickedFile.path.endsWith('.mp4')) {
//         _videoFile = File(pickedFile.path);
//         _videoPlayerController = VideoPlayerController.file(_videoFile)..initialize().then((_) {
//           setState(() {});
//         });
//       } else {
//         _imageFile = File(pickedFile.path);
//         _videoFile = null;
//         _videoPlayerController?.dispose();
//       }
//     } else {
//       print('No media selected.');
//     }
//   });
// }
