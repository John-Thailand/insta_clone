import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/location.dart';
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';
import 'package:insta_clone/utils/constants.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;
  PostViewModel({required this.userRepository, required this.postRepository});

  File? imageFile;

  Location? location;
  String locationString = "";

  String caption = "";

  bool isProcessing = false;
  bool isImagePicked = false;

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);

    location = await postRepository.getCurrentLocation();
    locationString = (location != null) ? _toLocationString(location!) : "";
    print(locationString);

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }

  String _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }

  Future<void> updateLocation(double latitude, double longitude) async {
    location = await postRepository.updateLocation(latitude, longitude);
    locationString = _toLocationString(location!);
    notifyListeners();
  }

  Future<void> post() async {
    if (imageFile == null) return;

    isProcessing = true;
    notifyListeners();

    await postRepository.post(
      UserRepository.currentUser!,
      imageFile!,
      caption,
      location,
      locationString,
    );

    isProcessing = false;
    isImagePicked = false;
    notifyListeners();
  }

  void cancelPost() async {
    isProcessing = false;
    isImagePicked = false;
    notifyListeners();
  }
}
