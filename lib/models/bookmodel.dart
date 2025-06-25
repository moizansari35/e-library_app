class BookModel {
  String? id;
  String? title;
  String? description;
  int? pages;
  String? language;
  String? author;
  String? aboutAuthor;
  String? bookurl;
  String? category;
  String? coverUrl;
  int? price;
  String rating = "4.5";
  String numberofRating = "300";

  BookModel(
      {this.id,
      this.title,
      this.description,
      this.pages,
      this.language,
      this.author,
      this.aboutAuthor,
      this.bookurl,
      this.category,
      this.price,
      this.coverUrl,
      this.rating = "4.5",
      this.numberofRating = "300"});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      aboutAuthor: json['aboutAuthor'] as String,
      pages: json['pages'] as int,
      price: json['price'] as int,
      language: json['language'] as String,
      bookurl: json['bookurl'] as String,
      coverUrl: json['coverUrl'] as String,
      rating: json['rating'] as String? ?? "4.5",
      numberofRating: json['numberOfRating'] as String? ?? "300",
    );
  }

  // BookModel.fromJson(Map<String, dynamic> json) {
  //   if (json["id"] is String) {
  //     id = json["id"];
  //   }
  //   if (json["title"] is String) {
  //     title = json["title"];
  //   }
  //   if (json["description"] is String) {
  //     description = json["description"];
  //   }
  //   if (json["rating"] is String) {
  //     rating = json["rating"];
  //   }
  //   if (json["pages"] is int) {
  //     pages = json["pages"];
  //   }
  //   if (json["language"] is String) {
  //     language = json["language"];
  //   }
  //   if (json["author"] is String) {
  //     author = json["author"];
  //   }
  //   if (json["aboutAuthor"] is String) {
  //     aboutAuthor = json["aboutAuthor"];
  //   }
  //   if (json["bookurl"] is String) {
  //     bookurl = json["bookurl"];
  //   }
  //   if (json["category"] is String) {
  //     category = json["category"];
  //   }
  //   if (json["coverUrl"] is String) {
  //     coverUrl = json["coverUrl"];
  //   }
  //   if (json["price"] is int) {
  //     price = json["price"];
  //   }
  //   if (json["numberofRating"] is int) {
  //     numberofRating = json["numberofRating"];
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["pages"] = pages;
    _data["language"] = language;
    _data["author"] = author;
    _data["aboutAuthor"] = aboutAuthor;
    _data["bookurl"] = bookurl;
    _data["category"] = category;
    _data["coverUrl"] = coverUrl;
    _data["price"] = price;
    _data["rating"] = rating;
    _data["numberofRating"] = numberofRating;
    return _data;
  }
}
