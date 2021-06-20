class Environment {
  late String _mode;
  final String _urlProd = 'http://147.83.7.159:9090/api/';
  final String _urlDev = 'http://localhost:8080/api/';
  final String _urlMobile = 'http://10.0.2.2:8080/api';

  static final Environment _instance = Environment._internal();

  factory Environment() => _instance;

  set mode(String mod) => _mode = mod;

  String get mode => _mode;

  String url() {
    if (_mode == "DEV") {
      return _urlDev;
    } else {
      return _urlProd;
    }
  }

  Environment._internal() {
    _mode = "";
  }
}
