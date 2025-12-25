part of 'transactions_cubit.dart';

sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

final class TransactionsInitial extends TransactionsState {}

final class TransactionsSuccess extends TransactionsState {
  final List<Map<String, dynamic>> transactions;
  const TransactionsSuccess(this.transactions);
}

final class TransactionsFailure extends TransactionsState {
  final String error;
  const TransactionsFailure(this.error);
}

final class TransactionsLoading extends TransactionsState {}
