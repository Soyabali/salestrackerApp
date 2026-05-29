import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/todo.dart';

 class TempleService {

  Future<List<TempleModel>> getAll() async {
   ///TODO ADD BASE URL AFTER THAT CANCATINATE URL
    ///
  const url="https://jsonplaceholder.typicode.com/todos";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if(response.statusCode == 200){
    // response decode after parse as a list its means response
    // return as a list
    final json = jsonDecode(response.body) as List;
    print('api response 12.----->---.xxxx $json');
    // iterate the data
    // to convert response into the model after that return
    // response as a list
    final todos = json.map((e)
    {
      return TempleModel(
          id: e['id'],
          userId: e['userId'],
          title: e['title'],
          completed: e['completed'],
      );
    }).toList();
    return todos;
  }
  return [];
  }
}