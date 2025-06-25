// import 'package:e_library/config/colors.dart';
// import 'package:e_library/models/bookmodel.dart';
// import 'package:e_library/screens/book%20details/bookActionButtons.dart';
// import 'package:e_library/screens/book%20details/bookDetailsCard.dart';
// import 'package:flutter/material.dart';

// class BookDetails extends StatelessWidget {
//   final BookModel bookModel;
//   const BookDetails({super.key, required this.bookModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               height: MediaQuery.sizeOf(context).height * 60 / 100,
//               color: MyColors.primaryColor,
//               child: BookDetailsCard(
//                 coverUrl: bookModel.coverUrl!,
//                 title: bookModel.title!,
//                 author: bookModel.author!,
//                 description: bookModel.description!,
//                 rating: bookModel.rating,
//                 pages: bookModel.pages.toString(),
//                 langugae: bookModel.language.toString(),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "About Book",
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   color: MyColors.blackColor,
//                                 ),
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     bookModel.description!,
//                     style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                           color: MyColors.lebelColor,
//                         ),
//                     maxLines: 4,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "Author Name",
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   color: MyColors.blackColor,
//                                 ),
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     bookModel.author!,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: MyColors.lebelColor,
//                         ),
//                     maxLines: 1,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "About Author",
//                         style:
//                             Theme.of(context).textTheme.titleMedium?.copyWith(
//                                   color: MyColors.blackColor,
//                                 ),
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     bookModel.aboutAuthor!,
//                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: MyColors.lebelColor,
//                         ),
//                     maxLines: 4,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: BookActionButtons(
//                 bookTitle: bookModel.title!,
//                 bookUrl: bookModel.bookurl!,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
