import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  Rx<XFile> image = XFile('').obs;
  RxBool isPicked = false.obs;

  void getImage({bool isCamera}) async {
    XFile file;

    if (isCamera) {
      file = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      file = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (file != null) {
      image.value = XFile(file.path);
    }
  }
}
