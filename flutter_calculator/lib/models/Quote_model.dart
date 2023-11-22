// ignore_for_file: public_member_api_docs, sort_constructors_first
class Quote {
  int id;
  String title;
  String image;
  String description;

  Quote({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        description: json['description']);
  }
}
