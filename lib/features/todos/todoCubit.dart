import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

abstract class TodoState {}

class TodoFetchInitial extends TodoState {}

class TodoFetchInProgress extends TodoState {}

class TodoFetchSuccessful extends TodoState {
  final List<int> todoIds;

  TodoFetchSuccessful(this.todoIds);
}

class TodoFetchFailure extends TodoState {
  final String errorMessage;

  TodoFetchFailure(this.errorMessage);
}

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoFetchInitial()) {
    fetchTodos();
  }

  void fetchTodos() async {
    emit(TodoFetchInProgress());
    try {
      final result = await http
          .post(Uri.parse("https://jsonplaceholder.typicode.com/todos"));

      print(result.body);

      emit(TodoFetchSuccessful([1, 2, 3, 4]));
    } on SocketException catch (_) {
      emit(TodoFetchFailure("No internet error message"));
    } catch (e) {
      emit(TodoFetchFailure(e.toString()));
    }
  }
}
