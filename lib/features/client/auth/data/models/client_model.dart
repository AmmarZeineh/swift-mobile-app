import 'package:swift_mobile_app/features/client/auth/domain/entities/client_entity.dart';

class ClientModel {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String role = 'Client';

  ClientModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json['id'],
    userName: json['name'],
    email: json['email'],
    phoneNumber: json['phone'],
  );

  toJson() => {
    'id': id,
    'name': userName,
    'email': email,
    'phone': phoneNumber,
  };

  factory ClientModel.fromEntity(ClientEntity clientEntity) => ClientModel(
    id: clientEntity.id,
    userName: clientEntity.userName,
    email: clientEntity.email,
    phoneNumber: clientEntity.phoneNumber,
  );

  ClientEntity toEntity() {
    return ClientEntity(
      id: id,
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
