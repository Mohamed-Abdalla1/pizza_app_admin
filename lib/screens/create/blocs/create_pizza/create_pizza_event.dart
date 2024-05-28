part of 'create_pizza_bloc.dart';

sealed class CreatePizzaEvent extends Equatable {
  const CreatePizzaEvent();

  @override
  List<Object> get props => [];
}

class CreatePizzaRequired {
  final PizzaModel pizzaModel;

  CreatePizzaRequired({required this.pizzaModel});
}
