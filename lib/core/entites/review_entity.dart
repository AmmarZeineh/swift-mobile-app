class ReviewEntity {
  final int id;
  final String userName;
  final int productId;
  final String comment;
  final num rate;
  final String date;

  ReviewEntity({
    required this.id,
    required this.userName,
    required this.productId,
    required this.comment,
    required this.rate,
    required this.date,
  });
}
