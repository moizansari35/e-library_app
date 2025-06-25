// import 'package:flutter/material.dart';
// import 'package:e_library/models/bookmodel.dart';
// import 'package:e_library/config/colors.dart';

// class BookDetailsSection extends StatelessWidget {
//   final BookModel bookModel;

//   const BookDetailsSection({super.key, required this.bookModel});

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildSectionTitle("About Book", textTheme.titleMedium),
//           _buildSectionContent(
//             bookModel.description!,
//             textTheme.labelMedium,
//           ),
//           const SizedBox(height: 10),
//           _buildSectionTitle("Author Name", textTheme.titleMedium),
//           _buildSectionContent(bookModel.author!, textTheme.bodyMedium),
//           const SizedBox(height: 10),
//           _buildSectionTitle("About Author", textTheme.titleMedium),
//           _buildSectionContent(bookModel.aboutAuthor!, textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title, TextStyle? style) {
//     return Text(
//       title,
//       style: style?.copyWith(color: MyColors.blackColor),
//       maxLines: 1,
//     );
//   }

//   Widget _buildSectionContent(String content, TextStyle? style) {
//     return Text(
//       content,
//       style: style?.copyWith(color: MyColors.lebelColor),
//       maxLines: 4,
//     );
//   }
// }
