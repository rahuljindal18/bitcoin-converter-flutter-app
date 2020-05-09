import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '';
const baseUrl = 'https://rest.coinapi.io/v1/exchangerate/';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getData(currency) async {
    Map<String, String> coinMap = {};
    for (String crypto in cryptoList) {
      String url = '$baseUrl$crypto/$currency?apiKey=$apiKey';
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        double rate = decodedData['rate'];
        coinMap[crypto] = rate.toStringAsFixed(1);
      } else {
        print(response.statusCode);
        throw 'problem with get request';
      }
    }
    return coinMap;
  }
}
