part of 'loaner_bloc.dart';

abstract class LoanerState extends Equatable {
  const LoanerState();
  
  @override
  List<Object?> get props => [];
}

class LoanerStateLoading extends LoanerState {}

class LoanerStateGetAll extends LoanerState {
  final List<LoanerModel> data;

  LoanerStateGetAll({required this.data});


    @override
  List<Object?> get props => [data];
}
