import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_library/config/toast_message.dart';
import 'package:e_library/screens/homescreen/homeScreen.dart';
import 'package:e_library/screens/welcomeScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  Rx<File?> selectedProfileImage = Rx<File?>(null);
  Rx<File?> selectedNewProfileImage = Rx<File?>(null);
  String profileImageUrl = "";
  RxBool isProfileImageUploading = false.obs;
  RxString username = ''.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Initialize username with current username
    username.value = auth.currentUser?.displayName ?? '';
  }

  void signinWithGoogle() async {
    isLoading.value = true;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await auth.signInWithCredential(credential);
      successMessage("Login Successful");
      Get.offAll(() => HomeScreen());
    } catch (ex) {
      errorMessage("Error ! Try again");
      debugPrint(ex.toString());
    }
    isLoading.value = false;
  }

  void signOut() async {
    auth.signOut();
    successMessage("Logout Successful");
    Get.offAll(() => const WelcomeScreen());
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      successMessage('Login Success');
      Get.offAll(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      errorMessage("Error While Login Try again !$e");
    }
    isLoading.value = false;
  }

  //final ImagePicker imagePicker = ImagePicker();
  XFile? pickedProfileImage;

  Future<void> pickProfileImage() async {
    isProfileImageUploading.value = true;
    pickedProfileImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedProfileImage != null) {
      selectedProfileImage.value = File(
        (pickedProfileImage!.path),
      );
    }
    isProfileImageUploading.value = false;
  }

  Future<String> uploadProfilePicture(XFile imageFile) async {
    if (selectedProfileImage.value != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${auth.currentUser!.uid}');
      UploadTask uploadTask =
          storageReference.putFile(selectedProfileImage.value!);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    }
    throw "No Data";
  }

  Future<void> signupWithEmailPassword(String email, String password,
      String username, XFile? profileImage) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        String? photoURL;

        // Upload profile picture if available
        if (profileImage != null) {
          photoURL = await uploadProfilePicture(profileImage);
        }

        // Set displayName and photoURL
        await user.updateDisplayName(username);
        if (photoURL != null) {
          await user.updatePhotoURL(photoURL);
        }
        await user.reload(); // Reload to apply the changes

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'photoURL': photoURL,
        });

        successMessage('SignUp Success');
        Get.offAll(HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      errorMessage("Error While Signing Up. Try again! $e");
    }
    isLoading.value = false;
  }

  // Future<void> updateProfile(String newUsername, XFile? newProfileImage) async {
  //   isProfileImageUploading.value = true;

  //   try {
  //     final user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       String? photoURL;

  //       // Upload new profile picture if available
  //       if (newProfileImage != null) {
  //         photoURL = await uploadProfilePicture(newProfileImage);
  //       }

  //       // Update user profile
  //       await user.updateDisplayName(newUsername);
  //       if (photoURL != null) {
  //         await user.updatePhotoURL(photoURL);
  //       }
  //       await user.reload(); // Reload to apply changes

  //       // Update user data in Firestore
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(user.uid)
  //           .update({
  //         'username': newUsername,
  //         'photoURL': photoURL,
  //       });

  //       successMessage('Profile updated successfully');
  //     }
  //   } catch (e) {
  //     errorMessage("Error while updating profile. Try again! $e");
  //   } finally {
  //     isProfileImageUploading.value = false;
  //   }
  // }
}
