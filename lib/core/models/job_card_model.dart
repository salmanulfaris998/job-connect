class JobCardModel {
  final String imageUrl;
  final String price;
  final String title;
  final String location;
  final bool isSaved;

  const JobCardModel({
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.location,
    this.isSaved = false,
  });
}
