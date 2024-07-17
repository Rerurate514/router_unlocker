import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpController{
  Future<http.Response> getHttp(Uri reqHeader) async {

    var response = await http.get(reqHeader);

    return response;
  }
}

class HeadrCreater{
  final String URL = "192.168.0.1";

  Uri getHeader(Base64Controller base64){
    var req = Uri.http(
      URL, 
      "/", 
      { 
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7', 
        'Accept-Encoding': 'gzip, deflate', 
        'Accept-Language': 'ja,en;q=0.9,en-GB;q=0.8,en-US;q=0.7', 
        'Authorization': 'Basic ${base64.encodedText}', 
        'Cache-Control': 'max-age=0', 
        'Connection': 'keep-alive', 
        'Host': '192.168.0.1', 
        'Upgrade-Insecure-Requests': '1', 
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36 Edg/126.0.0.0' 
      }
    );

    return req;
  }
}

class Base64Controller{
  late final String _encodedText;
  String get encodedText => _encodedText;

  void encodeText(String name, String password){
    String text = "$name:$password";
    _encodedText = base64Encode(
      utf8.encode(text)
    );
  }
}
