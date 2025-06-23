class SellerEntity {
  final String id;
  final int sellerId;
  final String userName;
  final String email;
  final String phoneNumber;
  final String storeName;
  final String storeAddress;
  final String role = 'seller';
  String image;

  SellerEntity({
    required this.sellerId,
    required this.id,
    required this.image,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.storeName,
    required this.storeAddress,
  });
}
