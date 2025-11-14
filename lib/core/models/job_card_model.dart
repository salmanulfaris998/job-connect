class JobCardModel {
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final String category;
  final bool isSaved;

  const JobCardModel({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.category,
    this.isSaved = false,
  });
}
