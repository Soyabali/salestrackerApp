import 'package:flutter/foundation.dart';

import '../model/todo.dart';
import '../services/todo_services.dart';
// this is a provider class
class TempleProvider extends ChangeNotifier {
  // create  a instance of service class
  final _service = TempleService();
  bool isLoading=false;
  // take a empty model that have a list.
  List<TempleModel> _todos=[];
  // get the response data here todos is a variable that store the api response.
  List<TempleModel> get todos => _todos;
  // bind provider to service
  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    _todos=response;
    isLoading = false;
    print('Provide api response 21...xxx $_todos');
    notifyListeners();
  }
}