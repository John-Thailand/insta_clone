import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/models/repositories/post_repository.dart';
import 'package:insta_clone/models/repositories/user_repository.dart';
import 'package:insta_clone/utils/constants.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  ProfileViewModel(
      {required this.userRepository, required this.postRepository});

  late User profileUser;
  User get currentUser => UserRepository.currentUser!;

  bool isProcessing = false;

  List<Post> posts = [];

  void setProfileUser(ProfileMode profileMode, User? selectedUser) {
    if (profileMode == ProfileMode.MYSELF) {
      profileUser = currentUser;
    } else {
      profileUser = selectedUser!;
    }
  }

  Future<void> getPost() async {
    isProcessing = true;
    notifyListeners();

    posts = await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser);

    isProcessing = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    notifyListeners();
  }

  Future<int> getNumberOfPosts() async {
    return (await postRepository.getPosts(FeedMode.FROM_PROFILE, profileUser))
        .length;
  }

  Future<int> getNumberOfFollowers() async {
    return await userRepository.getNumberOfFollowers(profileUser);
  }

  Future<int> getNumberOfFollowings() async {
    return await userRepository.getNumberOfFollowings(profileUser);
  }

  Future<String> pickProfileImage() async {
    final pickedImage = await postRepository.pickImage(UploadType.GALLERY);
    return (pickedImage != null) ? pickedImage.path : "";
  }

  Future<void> updateProfile(
    String nameUpdated,
    String bioUpdated,
    String photoUrlUpdated,
    bool isImageFromFile,
  ) async {
    isProcessing = true;
    notifyListeners();

    await userRepository.updateProfile(
      profileUser,
      nameUpdated,
      bioUpdated,
      photoUrlUpdated,
      isImageFromFile,
    );

    await userRepository.getCurrentUserById(profileUser.userId);
    profileUser = currentUser;

    isProcessing = false;
    notifyListeners();
  }
}