import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        pickedImage.value = image;
      } else {
        Get.snackbar("No Image", "You did not pick an image.");
      }
    } catch (e) {
      Get.snackbar("Error", "Image pick failed: $e");
    }
  }
}
