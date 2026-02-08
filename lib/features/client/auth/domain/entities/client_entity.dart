class ClientEntity {
  final String id;
  final String userName;
  final String email;
  final String phoneNumber;
  final String role = 'client';

  ClientEntity({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
  });

  ClientEntity copyWith({
    String? id,
    String? userName,
    String? email,
    String? phoneNumber,
  }) => ClientEntity(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );
}
