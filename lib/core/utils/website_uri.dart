Uri? websiteUri(String? raw) {
  var value = raw?.trim() ?? '';
  if (value.isEmpty) return null;
  final lower = value.toLowerCase();
  if (lower.contains(' ') || lower.startsWith('sin ')) return null;
  if (!value.contains('.')) return null;
  if (!lower.startsWith('http://') && !lower.startsWith('https://')) {
    value = 'https://$value';
  }
  final uri = Uri.tryParse(value);
  if (uri == null || uri.host.isEmpty) return null;
  if (uri.scheme != 'http' && uri.scheme != 'https') return null;
  return uri;
}
