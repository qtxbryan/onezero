import 'package:onezero/models/resale.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Resale?> getResale() async {
    var client = http.Client();

    var uri = Uri.parse(
        'https://data.gov.sg/api/action/datastore_search?resource_id=f1765b54-a209-4718-8d38-a39237f502b3&q=2016&limit=5460');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return resaleFromJson(json);
    } else {
      throw Exception('Failed to load Resale Data');
    }
  }
}
