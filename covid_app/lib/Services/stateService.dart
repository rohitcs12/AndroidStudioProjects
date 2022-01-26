  import 'dart:convert';

  import 'package:covid_app/Constantlib/statestring.dart';
  import 'package:http/http.dart' as http;
  import 'package:covid_app/models/statedata.dart';
  class StateManager{
    Future<List> getState() async
    {
  try{
        var client = http.Client();
        List statedata=[];
        final  response = await client.get(Uri.parse(strings.newStatUrl));
        if (response.statusCode == 200) {
          var data=json.decode(response.body);
          statedata=data["states"];
          return statedata;
        }
        else
          {
            throw Exception('Failed to data load');
          }
        }
        catch(Exception) {
    throw Exception("unable to connect to server");
        }
      }
      Future<List> loadData(int id) async{
        try{
          var client = http.Client();
          List statedata=[];
          final  response = await client.get(Uri.parse(strings.districtfecthurl+id.toString()));
          if (response.statusCode == 200) {
            var data=json.decode(response.body);
            statedata=data["districts"];
            return statedata;
          }
          else
          {
            throw Exception('Failed to data load');
          }
        }
        catch(Exception) {
          throw Exception("unable to connect to server");
        }
      }
    }
