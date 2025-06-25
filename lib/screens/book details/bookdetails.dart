import 'package:e_library/config/colors.dart';
import 'package:e_library/models/bookmodel.dart';
import 'package:e_library/screens/book%20details/bookActionButtons.dart';
import 'package:e_library/screens/book%20details/bookDetailsCard.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  final BookModel bookModel;
  const BookDetails({super.key, required this.bookModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: screenHeight * 0.6,
              color: MyColors.primaryColor,
              child: BookDetailsCard(
                coverUrl: bookModel.coverUrl!,
                title: bookModel.title!,
                author: bookModel.author!,
                description: bookModel.description!,
                rating: bookModel.rating,
                pages: bookModel.pages.toString(),
                langugae: bookModel.language.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("About Book", textTheme.titleMedium),
                  _buildSectionContent(
                      bookModel.description!, textTheme.labelMedium),
                  const SizedBox(height: 10),
                  _buildSectionTitle("Author Name", textTheme.titleMedium),
                  _buildSectionContent(bookModel.author!, textTheme.bodyMedium),
                  const SizedBox(height: 10),
                  _buildSectionTitle("About Author", textTheme.titleMedium),
                  _buildSectionContent(
                      bookModel.aboutAuthor!, textTheme.bodyMedium),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: BookActionButtons(
                bookTitle: bookModel.title!,
                bookUrl: bookModel.bookurl!,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextStyle? style) {
    return Text(
      title,
      style: style?.copyWith(color: MyColors.blackColor),
      maxLines: 1,
    );
  }

  Widget _buildSectionContent(String content, TextStyle? style) {
    return Text(
      content,
      style: style?.copyWith(color: MyColors.lebelColor),
      maxLines: 4,
    );
  }
}
