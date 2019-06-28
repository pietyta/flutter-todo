import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  @override
  TodoState get initialState => TodosLoading();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is LoadTodo) {
      yield TodosLoaded({'upcoming': [], 'completed': []});
    }

    if (event is AddTodo) {
      yield* _mapAddTodoToState(event);
    }

    if (event is CompleteTodo) {
      yield* _mapCompletedTodoToState(event);
    }
  }

  Stream<TodoState> _mapAddTodoToState(AddTodo event) async* {
    // add todo
    if (currentState is TodosLoaded) {
      var todoState = currentState as TodosLoaded;
      var todosMap = todoState.todos;
      todosMap['upcoming'] = [...todosMap['upcoming'], event.todo];

      yield (TodosLoaded(todosMap));
    }
  }

  Stream<TodoState> _mapCompletedTodoToState(CompleteTodo event) async* {
    // mark todo as complete and move
  }
}
