class Feeling {
  final int id;
  final String title;
  final int position;
  final String image;

  Feeling(
      {required this.id,
      required this.title,
      required this.position,
      required this.image});

  factory Feeling.fromJson(Map<String, dynamic> json) {
    return Feeling(
        id: json["id"],
        title: json["title"],
        position: json["position"],
        image: json["image"]);
  }
}
