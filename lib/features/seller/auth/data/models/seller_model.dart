import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';

class SellerModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String storeName;
  final String storeAddress;
  final String role = 'seller';
   String image;

  SellerModel({
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
  };

  factory SellerModel.fromEntity(SellerEntity sellerEntity) => SellerModel(
    id: sellerEntity.id,
    userName: sellerEntity.userName,
    email: sellerEntity.email,
    phoneNumber: sellerEntity.phoneNumber,
    storeName: sellerEntity.storeName,
    storeAddress: sellerEntity.storeAddress,
    image: sellerEntity.image,
  );
}
