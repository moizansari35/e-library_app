import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_library/config/toast_message.dart';
import 'package:e_library/models/bookmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController aboutAuthor = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController price = TextEditingController();
  // TextEditingController language = TextEditingController();
  RxString selectedLanguage = ''.obs;
  ImagePicker imagePicker = ImagePicker();
  final firebaseStorage = FirebaseStorage.instance;
  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxString imageUrl = "".obs;
  RxString pdfUrl = "".obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = false.obs;
  RxBool isLoading = false.obs;
  //File? selectedImage;
  //File? selectedPDF;
  Rx<File?> selectedPDF = Rx<File?>(null);
  Rx<File?> selectedImage = Rx<File?>(null);
  //var bookData = RxList<BookModel>();
  var userBookData = RxList<BookModel>();
  RxList<BookModel> bookData = <BookModel>[].obs;
  DocumentSnapshot? lastDocument;
  bool hasMoreBooks = true;

  // From Here Functions Start //

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllBooks();
    getUserBooks();
  }

  // Get all Books Function //
  // void getAllBooks() async {
  //   // Only fetch more if there are more books to load
  //   if (!hasMoreBooks) return;

  //   // Set loading state to true
  //   isLoading.value = true;

  //   try {
  //     Query query = fireStore.collection("Book Details").limit(10);

  //     if (lastDocument != null) {
  //       query = query.startAfterDocument(lastDocument!);
  //     }

  //     var booksSnapshot = await query.get();
  //     if (booksSnapshot.docs.isNotEmpty) {
  //       lastDocument = booksSnapshot.docs.last;

  //       for (var book in booksSnapshot.docs) {
  //         var bookDataMap = book.data() as Map<String, dynamic>;
  //         bookData.add(BookModel.fromJson(bookDataMap));
  //       }

  //       // If fewer than the limit are returned, then there are no more books to fetch
  //       if (booksSnapshot.docs.length < 10) {
  //         hasMoreBooks = false;
  //       }
  //     } else {
  //       hasMoreBooks = false; // No more books to fetch
  //     }
  //   } finally {
  //     // Set loading state to false
  //     isLoading.value = false;
  //   }
  // }
  void getAllBooks() {
    if (!hasMoreBooks || isLoading.value) return;

    isLoading.value = true;

    Query query = fireStore.collection("Book Details").limit(10);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    // Set up a real-time listener with pagination
    query.snapshots().listen((booksSnapshot) {
      if (booksSnapshot.docs.isNotEmpty) {
        lastDocument = booksSnapshot.docs.last;

        // Only add new books to avoid duplication
        for (var book in booksSnapshot.docs) {
          var bookDataMap = book.data() as Map<String, dynamic>;
          bookData.addIf(
            !bookData.any((existingBook) => existingBook.id == book.id),
            BookModel.fromJson(bookDataMap),
          );
        }

        // Check if fewer books were returned, meaning no more data to load
        hasMoreBooks = booksSnapshot.docs.length == 10;
      } else {
        hasMoreBooks = false;
      }
      // Shuffle the list of books to randomize the order
      bookData.shuffle();

      isLoading.value = false;
    });
  }

  // Get Only Current User Books Function //

  // void getUserBooks() async {
  //   // Set loading state to true
  //   isLoading.value = true;

  //   try {
  //     userBookData.clear();
  //     var books = await fireStore
  //         .collection("User Books")
  //         .doc(auth.currentUser!.uid)
  //         .collection("Books")
  //         .get();
  //     for (var book in books.docs) {
  //       userBookData.add(BookModel.fromJson(book.data()));
  //     }
  //   } finally {
  //     // Set loading state to false
  //     isLoading.value = false;
  //   }
  // }

  void getUserBooks() {
    isLoading.value = true;

    fireStore
        .collection("User Books")
        .doc(auth.currentUser!.uid)
        .collection("Books")
        .snapshots()
        .listen((booksSnapshot) {
      userBookData.clear();

      for (var book in booksSnapshot.docs) {
        userBookData.add(BookModel.fromJson(book.data()));
      }
      isLoading.value = false;
    });
  }

  // get all Books Old Function
  // void getAllBooks() async {
  //   bookData.clear();
  //   var books = await fireStore.collection("Book Details").get();
  //   for (var book in books.docs) {
  //     bookData.add(BookModel.fromJson(book.data()));
  //   }
  // }

  // Get only Current User Books Old Function //

  // void getUserBooks() async {
  //   isLoading.value = true;
  //   userBookData.clear();
  //   var books = await fireStore
  //       .collection("User Books")
  //       .doc(auth.currentUser!.uid)
  //       .collection("Books")
  //       .get();
  //   for (var book in books.docs) {
  //     userBookData.add(BookModel.fromJson(book.data()));
  //   }
  //   isLoading.value = false;
  // }

  // Pick Image Function //
  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      debugPrint(image.path);
      selectedImage.value = (File(image.path));
      //uploadImageToFirebase(File(image.path));
      isImageUploading.value = false;
    }
  }

  // Upload Image to Firebae Fuction //
  Future<void> uploadImageToFirebase() async {
    if (selectedImage.value == null) return;

    var uuid = const Uuid();
    var filename = uuid.v1();

    // Create a reference to the "Cover Images" folder in Firebase Storage
    var storageRef = firebaseStorage.ref().child("Book Cover Images/$filename");
    //var response =
    await storageRef.putFile(selectedImage.value!);
    String downloadUrl = await storageRef.getDownloadURL();

    imageUrl.value = downloadUrl;
    debugPrint("Downloaded URL: $downloadUrl");
  }

  // Pick PDF Function //
  void pickPDF() async {
    isPdfUploading.value = true;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        selectedPDF.value = File(result.files.first.path!);
      }
    } catch (e) {
      debugPrint("Error picking and uploading PDF: $e");
    }
    isPdfUploading.value = false;
  }

  //Upload PDF to Firebase Storage Function
  Future<void> uploadPDFtoFirebase() async {
    if (selectedPDF.value == null) return;

    File file = selectedPDF.value!;

    Uint8List fileBytes = await file.readAsBytes();
    String fileName = file.path.split('/').last;
    if (!fileName.endsWith('.pdf')) {
      fileName += '.pdf'; // Ensure the filename has a .pdf extension
    }

    //String fileName = file.path.split('/').last;

    debugPrint("File Bytes: $fileBytes");

    // Create a reference to the "Books PDF" folder in Firebase Storage
    //and uploading it to the Firebase//
    final response = await FirebaseStorage.instance
        .ref("Books PDF/$fileName")
        .putData(fileBytes);

    // debugPrint("Storage Bucket: ${response.storage.bucket}");

    final downloadUrl = await response.ref.getDownloadURL();
    pdfUrl.value = downloadUrl;
    debugPrint("Download URL: $downloadUrl");
  }

  // Create Book in Firebase Firestore and
  //Save the Image and PDF to Firebase Storage
  void createBook() async {
    isPostUploading.value = true;

    // First upload image and PDF
    await uploadImageToFirebase();
    await uploadPDFtoFirebase();

    // Create book details only if both uploads are successful
    if (imageUrl.value.isNotEmpty && pdfUrl.value.isNotEmpty) {
      var newBook = BookModel(
        id: const Uuid().v4(),
        title: title.text,
        description: description.text,
        author: author.text,
        aboutAuthor: aboutAuthor.text,
        pages: int.parse(pages.text),
        price: int.parse(price.text),
        language: selectedLanguage.value,
        bookurl: pdfUrl.value,
        coverUrl: imageUrl.value,
      );
      try {
        await fireStore.collection("Book Details").add(newBook.toJson());
        addBooktoUserDB(newBook);

        successMessage("Book Uploaded");
        isPostUploading.value = false;
        clearForm();
      } catch (e) {
        errorMessage("Book not Uploaded ! Try Again");
      }
    }
    isPostUploading.value = false;
  }

  void clearForm() {
    title.clear();
    description.clear();
    author.clear();
    aboutAuthor.clear();
    pages.clear();
    price.clear();
    selectedLanguage.value = '';
    selectedImage.value = null;
    selectedPDF.value = null;
    update();
    getAllBooks();
    getUserBooks();
  }

  void addBooktoUserDB(
    BookModel book,
  ) async {
    await fireStore
        .collection("User Books")
        .doc(auth.currentUser!.uid)
        .collection("Books")
        .add(book.toJson());
  }
}
