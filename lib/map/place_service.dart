import 'package:farm_plus/src/model/place.dart';
import 'package:farm_plus/src/model/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyCvhmrgLqmokeCD-5pyUE5sHN-0hgfRjhs';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=new&types=(cities)&language=&key=AIzaSyCvhmrgLqmokeCD-5pyUE5sHN-0hgfRjhshttps://maps.googleapis.com/maps/api/place/autocomplete/json?input=new&types=(cities)&language=&key=AIzaSyCvhmrgLqmokeCD-5pyUE5sHN-0hgfRjhs';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCvhmrgLqmokeCD-5pyUE5sHN-0hgfRjhs';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(double lat, double lng,String placeType) async {
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=AIzaSyCvhmrgLqmokeCD-5pyUE5sHN-0hgfRjhs';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}