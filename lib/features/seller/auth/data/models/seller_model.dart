import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

class SellerModel {
  final String id;
  final int sellerId;
  final String userName;
  final String email;
  final String phoneNumber;
  final String storeName;
  final String storeAddress;
  final String role = 'seller';
  String image;

  SellerModel({
    required this.sellerId,
    required this.id,
    required this.image,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.storeName,
    required this.storeAddress,
  });

  toJson() => {
    'id': id,
    'name': userName,
    'email': email,
    'phone': phoneNumber,
    'store_name': storeName,
    'address': storeAddress,
    'imageUrl': image,
    'sellerId': sellerId,
  };

  factory SellerModel.fromEntity(SellerEntity sellerEntity) => SellerModel(
    sellerId: sellerEntity.sellerId,
    id: sellerEntity.id,
    userName: sellerEntity.userName,
    email: sellerEntity.email,
    phoneNumber: sellerEntity.phoneNumber,
    storeName: sellerEntity.storeName,
    storeAddress: sellerEntity.storeAddress,
    image: sellerEntity.image,
  );

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    id: json['id'],
    sellerId: json['sellerId'],
    userName: json['name'],
    email: json['email'],
    phoneNumber: json['phone'],
    storeName: json['store_name'],
    storeAddress: json['address'],
    image: json['imageUrl'],
  );

  SellerEntity toEntity() => SellerEntity(
    sellerId: sellerId,
    id: id,
    userName: userName,
    email: email,
    phoneNumber: phoneNumber,
    storeName: storeName,
    storeAddress: storeAddress,
    image: image,
  );

  toJsonSignup() => {
    'id': id,
    'name': userName,
    'email': email,
    'phone': phoneNumber,
    'store_name': storeName,
    'address': storeAddress,
    'imageUrl': image,
  };
}
