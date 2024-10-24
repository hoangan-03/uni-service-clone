class MenuItem {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl, required int stock,
  });
}