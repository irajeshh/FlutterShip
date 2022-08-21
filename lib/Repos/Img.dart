import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImgRepo {
  ImgRepo._privateConstructor();
  static final ImgRepo _instance = ImgRepo._privateConstructor();
  static ImgRepo get instance => _instance;

  static final ImagePicker imagePicker = ImagePicker();

  static Future<File?> pick() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        maxWidth: 400,
        maxHeight: 400,
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop",
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.deepPurple,
            backgroundColor: Colors.black,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<bool> uploadProfilePhoto(File profileFile) async {
    String email =
        'user@fluttership.com'; // change this to FirebaseAuth.instance.currentUser.email;
    Reference profileref = FirebaseStorage.instance.ref().child('avatars/$email/avatar.jpg');
    UploadTask profiletask = profileref.putFile(profileFile);
    String imgUrl = await (await profiletask).ref.getDownloadURL();

    ///Alternatively you can return the [imgUrl]
    return imgUrl.contains('http');
  }

  static Future<String?> getImgUrl(String path) async {
    Reference reference = FirebaseStorage.instance.ref().child(path);
    try {
      String imgUrl = await reference.getDownloadURL();
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
