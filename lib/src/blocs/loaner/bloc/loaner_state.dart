part of 'loaner_bloc.dart';

abstract class LoanerState extends Equatable {
  const LoanerState();
  
  @override
  List<Object> get props => [];
}

class LoanerInitial extends LoanerState {}
