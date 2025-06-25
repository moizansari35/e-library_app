import 'package:e_library/Widgets/backButton.dart';
import 'package:e_library/config/colors.dart';
import 'package:e_library/controllers/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookReadScreen extends StatelessWidget {
  final String bookUrl;
  final String bookTitle;
  const BookReadScreen(
      {super.key, required this.bookUrl, required this.bookTitle});

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: MyBackButton(),
        ),
        leadingWidth: 100,
        backgroundColor: MyColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          bookTitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: MyColors.whiteColor,
              ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              "Assets/Icons/heart.svg",
              color: MyColors.whiteColor,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pdfController.pdfViewerKey.currentState?.openBookmarkView();
        },
        child: const Icon(
          Icons.bookmark,
          color: MyColors.whiteColor,
        ),
      ),
      body: SfPdfViewer.network(
        bookUrl,
        key: pdfController.pdfViewerKey,
      ),
    );
  }
}

// import 'package:e_library/Widgets/backButton.dart';
// import 'package:e_library/config/colors.dart';
// import 'package:e_library/controllers/PdfController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class BookReadScreen extends StatefulWidget {
//   final String bookUrl;
//   final String bookTitle;

//   const BookReadScreen(
//       {super.key, required this.bookUrl, required this.bookTitle});

//   @override
//   _BookReadScreenState createState() => _BookReadScreenState();
// }

// class _BookReadScreenState extends State<BookReadScreen> {
//   final PdfController pdfController = Get.put(PdfController());
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: MyBackButton(),
//         ),
//         leadingWidth: 100,
//         backgroundColor: MyColors.primaryColor,
//         automaticallyImplyLeading: false,
//         title: Text(
//           widget.bookTitle,
//           style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 color: MyColors.whiteColor,
//               ),
//         ),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: SvgPicture.asset(
//               "Assets/Icons/heart.svg",
//               color: MyColors.whiteColor,
//             ),
//           )
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           pdfController.pdfViewerKey.currentState?.openBookmarkView();
//         },
//         child: const Icon(
//           Icons.bookmark,
//           color: MyColors.whiteColor,
//         ),
//       ),
//       body: Stack(
//         children: [
//           SfPdfViewer.network(
//             widget.bookUrl,
//             key: pdfController.pdfViewerKey,
//             onDocumentLoaded: (_) {
//               setState(() {
//                 isLoading = false;
//               });
//             },
//           ),
//           if (isLoading)
//             Center(child: CircularProgressIndicator()), // Loading indicator
//         ],
//       ),
//     );
//   }
//}
