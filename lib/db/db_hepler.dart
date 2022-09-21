import '../utils/constraint.dart';
import 'package:http/http.dart'as http;

class DBHelper{
  static var client = http.Client();

  //static getSearchData(String api)async{}



    //GET
    static Future<dynamic> getSearchData(String api) async {
      try{
        var url = Uri.parse(baseUrl + api);
        // var _headers = {
        //   'Authorization': 'Bearer sfie328370428387=',
        //   'api_key': 'ief873fj38uf38uf83u839898989',
        // };

        var response = await client.get(url);
        if (response.statusCode == 200) {
          return response.body;
        } else {
          //throw exception and catch it in UI
        }
      }catch(e){

      }
    }


}