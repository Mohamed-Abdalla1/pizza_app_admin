import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'create_pizza_event.dart';
part 'create_pizza_state.dart';

class CreatePizzaBloc extends Bloc<CreatePizzaEvent, CreatePizzaState> {
  CreatePizzaBloc() : super(CreatePizzaInitial()) {
    on<CreatePizzaEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
