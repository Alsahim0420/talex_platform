import 'package:talex_platform/features/auth/data/models/auth_user_model.dart';
import 'package:talex_platform/features/auth/domain/entities/auth_user.dart';

extension AuthUserModelMapper on AuthUserModel {
  AuthUser toEntity() =>
      AuthUser(id: id, email: email, displayName: displayName);
}
