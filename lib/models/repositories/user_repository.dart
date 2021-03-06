import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/models/db/database_manager.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  final DatabaseManager dbManager;
  UserRepository({required this.dbManager});

  static User? currentUser;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> isSignIn() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    }
    return false;
  }

  Future<bool> signIn() async {
    try {
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        return false;
      }

      GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        idToken: signInAuthentication.idToken,
        accessToken: signInAuthentication.accessToken,
      );

      final firebaseUser = (await _auth.signInWithCredential(credential)).user;
      if (firebaseUser == null) {
        return false;
      }

      //TODO DBに登録
      final isUserExistedInDb = await dbManager.searchUserInDb(firebaseUser);

      if (!isUserExistedInDb) {
        await dbManager.insertUser(_convertToUser(firebaseUser));
      }
      currentUser = await dbManager.getUserInfoFromDbById(firebaseUser.uid);
      return true;
    } catch (error) {
      print("sign in error caught!: ${error.toString()}");
      return false;
    }
  }

  _convertToUser(auth.User firebaseUser) {
    return User(
      userId: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? "",
      inAppUserName: firebaseUser.displayName ?? "",
      photoUrl: firebaseUser.photoURL ?? "",
      email: firebaseUser.email ?? "",
      bio: "",
    );
  }

  // ユーザーIDの取得
  Future<User> getUserById(String userId) async {
    return await dbManager.getUserInfoFromDbById(userId);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    currentUser = null;
  }

  Future<int> getNumberOfFollowers(User profileUser) async {
    return (await dbManager.getFollowerUserIds(profileUser.userId)).length;
  }

  Future<int> getNumberOfFollowings(User profileUser) async {
    return (await dbManager.getFollowingUserIds(profileUser.userId)).length;
  }

  Future<void> updateProfile(
    User profileUser,
    String nameUpdated,
    String bioUpdated,
    String photoUrlUpdated,
    bool isImageFromFile,
  ) async {
    var updatePhotoUrl;

    if (isImageFromFile) {
      final updatePhotoFile = File(photoUrlUpdated);
      final storagePath = Uuid().v1();
      updatePhotoUrl =
          await dbManager.uploadImageToStrage(updatePhotoFile, storagePath);
    }

    final userBeforeUpdate =
        await dbManager.getUserInfoFromDbById(profileUser.userId);
    final updateUser = userBeforeUpdate.copyWith(
        inAppUserName: nameUpdated,
        photoUrl: isImageFromFile ? updatePhotoUrl : userBeforeUpdate.photoUrl,
        bio: bioUpdated);

    await dbManager.updateProfile(updateUser);
  }

  Future<void> getCurrentUserById(String userId) async {
    currentUser = await dbManager.getUserInfoFromDbById(userId);
  }

  Future<List<User>> searchUsers(String query) async {
    return dbManager.searchUser(query);
  }

  Future<void> follow(User profileUser) async {
    if (currentUser != null) await dbManager.follow(profileUser, currentUser!);
  }

  Future<bool> checkIsFollowing(User profileUser) async {
    return (currentUser != null)
        ? await dbManager.checkIsFollowing(profileUser, currentUser!)
        : false;
  }

  Future<void> unFollow(User profileUser) async {
    if (currentUser != null)
      await dbManager.unFollow(profileUser, currentUser!);
  }

  Future<List<User>> getCaresMeUsers(String id, WhoCaresMeMode mode) async {
    var results = <User>[];

    switch (mode) {
      case WhoCaresMeMode.LIKE:
        final postId = id;
        results = await dbManager.getLikesUsers(postId);
        break;
      case WhoCaresMeMode.FOLLOWED:
        final profileUserId = id;
        results = await dbManager.getFollowerUsers(profileUserId);
        break;
      case WhoCaresMeMode.FOLLOWINGS:
        final profileUserId = id;
        results = await dbManager.getFollowingUsers(profileUserId);
        break;
    }

    return results;
  }
}
