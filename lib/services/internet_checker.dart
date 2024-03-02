import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  final InternetConnectionChecker _checker = InternetConnectionChecker();

  Future<bool> get hasConnection async => await _checker.hasConnection;
}
