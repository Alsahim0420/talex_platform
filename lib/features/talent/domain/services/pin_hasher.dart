import 'dart:convert';

abstract final class PinHasher {
  static String hash(String pin, String email) {
    final bytes = utf8.encode('${email.trim().toLowerCase()}|$pin');
    var hash = 2166136261;
    for (final byte in bytes) {
      hash ^= byte;
      hash = (hash * 16777619) & 0xFFFFFFFF;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }

  static String generatePin() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return (100000 + (now % 900000)).toString();
  }
}

abstract final class InvitePin {
  static const lifetime = Duration(minutes: 15);
  static const length = 6;

  static DateTime expiresAt([DateTime? now]) =>
      (now ?? DateTime.now()).add(lifetime);

  static bool isExpired({
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? now,
  }) {
    final clock = now ?? DateTime.now();
    if (expiresAt != null) return !expiresAt.isAfter(clock);
    if (createdAt != null) return !createdAt.add(lifetime).isAfter(clock);
    return false;
  }
}
