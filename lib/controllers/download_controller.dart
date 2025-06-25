import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_library/config/toast_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DownloadController extends GetxController {
  var isDownloading = false.obs;
  final Dio dio = Dio();

  Future<void> saveFile(String fileName, List<int> fileBytes) async {
    try {
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Downloads directory is not available');
      }
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      print('File saved at $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  Future<File> getFile(String fileName) async {
    final directory = await getDownloadsDirectory();
    if (directory == null) {
      throw Exception('Downloads directory is not available');
    }
    final filePath = '${directory.path}/$fileName';
    return File(filePath);
  }

  Future<void> downloadFile(String url, String fileName) async {
    try {
      isDownloading.value = true;

      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Downloads directory is not available');
      }

      // final filePath = '${directory.path}/$fileName';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // final contentType = response.headers['content-type'] ?? '';
        //String extension = '';
        // if (contentType.contains('application/pdf')) {
        //   extension = '.pdf';
        // } else if (contentType.contains('image/jpeg')) {
        //   extension = '.jpg';
        // } else if (contentType.contains('image/png')) {
        //   extension = '.png';
        // } else {
        //   extension = '.bin'; // Default extension if unknown
        // }
        // final newFileName =
        //fileName.contains('.') ? fileName : '$fileName.$extension';
        //final newFilePath = '${directory.path}/$newFileName';

        //Assume .pdf extension
        final newFileName = fileName.contains('.') ? fileName : '$fileName.pdf';
        final newFilePath = '${directory.path}/$newFileName';

        final file = File(newFilePath);
        await file.writeAsBytes(response.bodyBytes);
        successMessage("PDF Downloaded Successfully");
        //successMessage("File downloaded to $newFilePath");
      } else {
        errorMessage("Failed to Download File");
      }
    } catch (e) {
      errorMessage("Error downloading file: $e");
    }

    isDownloading.value = false;
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      return null; // iOS does not have a public downloads directory
    }
    return null; // For other platforms, return null
  }
}


 // Old Code for Download Files //

// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:e_library/config/toast_message.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// class DownloadController extends GetxController {
//   var isDownloading = false.obs;
//   final Dio dio = Dio();

//   Future<void> saveFile(String fileName, List<int> fileBytes) async {
//     try {
//       // Get the directory
//       final directory = await getExternalStorageDirectory();
//       final filePath = '${directory!.path}/$fileName';

//       // Create the file
//       final file = File(filePath);

//       // Write the bytes to the file
//       await file.writeAsBytes(fileBytes);

//       print('File saved at $filePath');
//     } catch (e) {
//       print('Error saving file: $e');
//     }
//   }

//   Future<File> getFile(String fileName) async {
//     final directory = await getExternalStorageDirectory();
//     final filePath = '${directory!.path}/$fileName';
//     return File(filePath);
//   }

//   Future<void> downloadFile(String url, String fileName) async {
//     try {
//       isDownloading.value = true;
//       // Get the directory
//       final directory = await getExternalStorageDirectory();
//       final filePath = '${directory!.path}/$fileName';

//       // Download the file
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         successMessage("File downloaded to $filePath");
//       } else {
//         errorMessage("Failed to Download File");
//       }
//     } catch (e) {
//       errorMessage("Error downloading file: $e");
//     }
//     isDownloading.value = false;
//   }

//   Future<Directory?> getDownloadsDirectory() async {
//     if (Platform.isAndroid) {
//       // On Android, use the external downloads directory
//       return Directory('/storage/emulated/0/Download');
//     } else if (Platform.isIOS) {
//       // On iOS, you would need to use a different approach
//       // iOS does not have a public downloads directory accessible
//       return null;
//     }
//     return null;
//   }
// }