import 'package:fansedu_flutter_mobile/features/auth/domain/entities/user_entity.dart';

class UserModel {
  UserModel({required this.id, required this.email, this.name});

  final String id;
  final String email;
  final String? name;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      name: (json['name'] ?? json['full_name'])?.toString(),
    );
  }

  UserEntity toEntity() => UserEntity(id: id, email: email, name: name);
}
