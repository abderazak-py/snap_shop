part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<ProductEntity> products;

  const SearchSuccess({required this.products});
}

final class SearchFailure extends SearchState {
  final String error;

  const SearchFailure({required this.error});
}

final class SearchLoading extends SearchState {}
