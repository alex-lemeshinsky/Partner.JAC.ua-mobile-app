import 'package:http/http.dart';
import 'dart:convert';

Future<Map> fetchCarsTechonlogy() async {
  final responce = await get(
    "https://api.npoint.io/e8dda79bb429ac849af5",
    headers: {"Accept": "application/json"},
  );
  var convertedData = jsonDecode(responce.body);
  return convertedData;
}

Future<List> fetchWpPosts() async {
  final responce = await get(
      "https://jacua.org/wp-json/wp/v2/posts?per_page=25",
      headers: {"Accept": "application/json"});
  var convertedData = jsonDecode(responce.body);
  return convertedData;
}

dynamic fetchOrganizationPage() async {
  dynamic responce = await get(
    "https://api.npoint.io/0aff9cbb5f5fcecd9573",
    headers: {"Accept": "application/json"},
  );
  var page = jsonDecode(responce.body);
  return page;
}

dynamic fetchProcessPage() async {
  dynamic responce = await get(
    "https://api.npoint.io/76803a92cf31a6b4cf03",
    headers: {"Accept": "application/json"},
  );
  var page = jsonDecode(responce.body);
  return page;
}

dynamic fetchPdiPage() async {
  final responce =
      await get("https://jacua.org/wp-json/wp/v2/pages?per_page=25", headers: {
    "Accept": "application/json",
    "Authorization": "Basic YWxlbWVzaGluc2t5OlBkZVpTZzZOI3NCMSFGWms=",
  });
  var convertedData = jsonDecode(responce.body);
  var page = convertedData[13]["content"]["rendered"];
  return page;
}
