class Item {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      description: json['body'],
      imageUrl: 'https://via.placeholder.com/150',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'title': title,
      'body': description,
    };
  }
}