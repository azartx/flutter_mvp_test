import 'package:http/http.dart' as http;

class NetworkManager {
  NetworkManager(this._baseUrl);

  final String _baseUrl;

  Future<http.Response> makeCall(String path, Map<String, dynamic>? parameters) async {
    final url = Uri.https(_baseUrl, path, parameters);
    return await http.get(url);
  }

  bool isSuccess(http.Response response) {
    return response.statusCode == 200;
  }
}
