import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/paypal_transactions_usecase.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final PaypalTransactionsUsecase paypalTransactionsUsecase;
  TransactionsCubit({required this.paypalTransactionsUsecase})
    : super(TransactionsInitial());

  getTransactions() async {
    emit(TransactionsLoading());
    final result = await paypalTransactionsUsecase.execute();
    result.fold(
      (l) => emit(TransactionsFailure(l.message)),
      (r) => emit(TransactionsSuccess(r)),
    );
  }
}
