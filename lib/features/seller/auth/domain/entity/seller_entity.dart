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

  copyWith({
    String? id,
    int? sellerId,
    String? userName,
    String? email,
    String? phoneNumber,
    String? storeName,
    String? storeAddress,
    String? image,
  }) =>
      SellerEntity(
        id: id ?? this.id,
        sellerId: sellerId ?? this.sellerId,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        storeName: storeName ?? this.storeName,
        storeAddress: storeAddress ?? this.storeAddress,
        image: image ?? this.image,
      );
}
