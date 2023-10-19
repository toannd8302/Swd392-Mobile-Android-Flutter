import 'dart:convert';

import 'package:http/http.dart' as http;

class locationService {
  final String key = 'AIzaSyA9jSnM9fMvTTgQ-M-ul4wlITrxpgsFSJM';
  Future<String> getPlacedId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));

    var json = jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;
    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>>getPlace(String input) async{
    final placeId = await getPlacedId(input);
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var result = json['result'] as Map<String, dynamic>;
    print(result);
    return result;
}
}