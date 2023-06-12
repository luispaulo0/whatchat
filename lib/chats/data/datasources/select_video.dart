import 'package:image_picker/image_picker.dart';

Future<XFile?> getVideo() async {
  final ImagePicker picker = ImagePicker();
  final XFile? video =
      await picker.pickVideo(source: ImageSource.gallery);

  return video;
}
