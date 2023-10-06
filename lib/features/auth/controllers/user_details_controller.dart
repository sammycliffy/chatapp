import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speso_chatapp/shared/utils/attachment_utils.dart';
// import 'package:speso_chatapp/shared/widgets/emoji_picker.dart';
import 'package:speso_chatapp/shared/widgets/gallery.dart';

import '../../../shared/repositories/compression_service.dart';

final userDetailsControllerProvider =
    StateNotifierProvider.autoDispose<UserDetailsController, File?>(
        (ref) => UserDetailsController(ref));

class UserDetailsController extends StateNotifier<File?> {
  final AutoDisposeStateNotifierProviderRef ref;

  late final TextEditingController _usernameController;
  UserDetailsController(this.ref) : super(null);

  TextEditingController get usernameController => _usernameController;

  void deleteImage(BuildContext context) {
    state = null;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _usernameController.dispose();
    super.dispose();
  }

  void init() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _usernameController = TextEditingController();
    // ref
    //     .read(emojiPickerControllerProvider.notifier)
    //     .init(keyboardVisibility: true);
  }

  void setImageFromCamera(BuildContext context) async {
    final image = await capturePhoto();
    if (image == null) return;
    state = await CompressionService.compressImage(image);
  }

  Future<void> setImageFromGallery(BuildContext context) async {
    if (Platform.isAndroid) {
      final file = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Gallery(
          title: 'Pick a photo',
          returnFiles: true,
        ),
        settings: const RouteSettings(name: "/gallery"),
      ));

      state = await CompressionService.compressImage(file);
      return;
    }

    final image = await pickImageFromGallery();
    if (image == null) return;
    state = await CompressionService.compressImage(image);
  }
}
