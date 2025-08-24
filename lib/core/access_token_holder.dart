class AccessTokenHolder {
  String? _token;
  String? get token => _token;
  void set(String t) => _token = t;
  void clear() => _token = null;
}
