import 'dart:async';

class AuthService {
  final StreamController<bool> _onAuthStateChanged =
      StreamController<bool>.broadcast();

  Stream<bool> get onAuthStateChanged => _onAuthStateChanged.stream;

  Future<bool> login() async {
    // This is just to demonstrate the login process time.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    await Future.delayed(const Duration(seconds: 3));

    _onAuthStateChanged.add(true);
    return true;
  }

  void logout() {
    _onAuthStateChanged.add(false);
  }
}
