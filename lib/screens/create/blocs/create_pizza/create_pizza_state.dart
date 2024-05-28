part of 'create_pizza_bloc.dart';

sealed class CreatePizzaState extends Equatable {
  const CreatePizzaState();
  
  @override
  List<Object> get props => [];
}

final class CreatePizzaInitial extends CreatePizzaState {}
