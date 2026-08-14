
class Category {
  int id;
  String title;
  String image;

  Category({required this.id, required this.image, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], title: json["title"], image: json["image"]);
  }

}
