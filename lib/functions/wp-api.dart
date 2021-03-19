import 'package:http/http.dart';
import 'dart:convert';

Future<Map> fetchCarsTechonlogy() async {
  final responce = await get(
    Uri.https("api.npoint.io", "/aa6439383eb457bd15ef"),
    headers: {"Accept": "application/json"},
  );
  var convertedData = jsonDecode(responce.body);
  return convertedData;
}

Future<List> fetchWpPosts() async {
  final responce = await get(
      Uri.https("jacua.org", "/wp-json/wp/v2/posts", {"per_page": "25"}),
      headers: {"Accept": "application/json"});
  var convertedData = jsonDecode(responce.body);
  return convertedData;
}

dynamic fetchOrganizationPage() async {
  dynamic responce = await get(
    Uri.https("api.npoint.io", "/7176adf717400e3625af"),
    headers: {"Accept": "application/json"},
  );
  var page = jsonDecode(responce.body);
  return page;
}

dynamic fetchProcessPage() async {
  dynamic responce = await get(
    Uri.https("api.npoint.io", "/c889be31aedd4972a55d"),
    headers: {"Accept": "application/json"},
  );
  var page = jsonDecode(responce.body);
  return page;
}

dynamic fetchPdiPage() async {
  final responce = await get(
      Uri.https("jacua.org", "/wp-json/wp/v2/pages", {"per_page": "25"}),
      headers: {
        "Accept": "application/json",
        "Authorization": "Basic YWxlbWVzaGluc2t5OlBkZVpTZzZOI3NCMSFGWms=",
      });
  var convertedData = jsonDecode(responce.body);
  var page = "";
  if (convertedData[14]["slug"] == "pdi") {
    page = convertedData[14]["content"]["rendered"];
  }
  return page;
}

dynamic postReport(
  String dateTime,
  String vin,
  String year,
  String model,
  String mileage,
  List<String> laborTypeSelected,
  List<String> laborDetailsSelected,
  String dealerCode,
  String dealerName,
  String email,
) async {
  print(
    laborTypeSelected
        .toString()
        .substring(1)
        .split('')
        .reversed
        .join()
        .substring(1)
        .split('')
        .reversed
        .join(),
  );
  print(
    laborDetailsSelected
        .toString()
        .substring(1)
        .split('')
        .reversed
        .join()
        .substring(1)
        .split('')
        .reversed
        .join(),
  );
  Uri url = Uri.https(
    "jacua.org",
    "/wp-json/contact-form-7/v1/contact-forms/1228/feedback",
  );
  // ignore: unused_local_variable
  var response = await post(
    url,
    body: {
      "throughtput-day": dateTime,
      "vin": vin,
      "car-model": model,
      "car-year": year,
      "car-mileage": mileage,
      "labor-type": laborTypeSelected
          .toString()
          .substring(1)
          .split('')
          .reversed
          .join()
          .substring(1)
          .split('')
          .reversed
          .join(),
      "labor-details": laborDetailsSelected
          .toString()
          .substring(1)
          .split('')
          .reversed
          .join()
          .substring(1)
          .split('')
          .reversed
          .join(),
      "dealer-code": dealerCode,
      "dealer-name": dealerName,
      "your-email": email,
    },
  );
  /*print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');*/
}
