import 'package:image_picker/image_picker.dart';
class ImageUploadModel{
  bool isUploaded;
  bool uploading;
 XFile imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}