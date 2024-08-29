import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:thaijourney/core/sessions_listener.dart';

class ProfilePictureUploader {
  final BuildContext context;

  ProfilePictureUploader({required this.context});
  final User? user = FirebaseAuth.instance.currentUser;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .refFromURL(
          'https://thaijourney-4881b-default-rtdb.asia-southeast1.firebasedatabase.app');

  final storageRef = FirebaseStorage.instance.ref();
  final ImagePicker picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    SessionListener();
  }

  Future<void> uploadFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 90,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.orange,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
            ),
          ],
        );
        if (croppedFile != null) {
          _image = XFile(croppedFile.path);
          if (context.mounted) {
            uploadImage(context);
          }
        }
      } catch (e) {
        ('$e');
      }
    }
  }

  Future<void> uploadFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        // Crop the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 90,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.orange,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
            ),
          ],
        );

        if (croppedFile != null) {
          _image = XFile(croppedFile.path);
          if (context.mounted) {
            uploadImage(context);
          }
        }
      } catch (e) {
        ('$e');
      }
    }
  }

  void pickImage(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  CupertinoIcons.camera_fill,
                  color: Colors.deepPurple,
                ),
                title: Text('Camera'),
                onTap: () async {
                  await ProfilePictureUploader(context: context).uploadFromCamera(context);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.photo_fill_on_rectangle_fill,
                  color: Colors.deepPurple,
                ),
                title: Text('Gallery'),
                onTap: () async {
                  await ProfilePictureUploader(context: context).uploadFromGallery(context);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }


  void uploadImage(context) async {
    setLoading(true);
    String imageName = "${user?.uid}_pic.jpg";
    final imageRef = storageRef.child('profilepic/$imageName');

    try {
      UploadTask uploadTask = imageRef.putFile(File(_image!.path));
      await uploadTask;

      String downloadURL = await imageRef.getDownloadURL();

      await _databaseReference.child('users/${user?.uid}').update({
        'profilepic': downloadURL,
      });
          SnackBar(content: Text('Profile picture uploaded and updated successfully!')
      );

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
          SnackBar(content: Text('Error uploading profile picture: $e')
          );
    } finally {
      setLoading(false);
    }
  }
}
