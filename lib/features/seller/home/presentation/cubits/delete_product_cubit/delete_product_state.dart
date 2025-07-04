part of 'delete_product_cubit.dart';

sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductFailure extends DeleteProductState {
  final String errMessage;

  const DeleteProductFailure(this.errMessage);
}

final class DeleteProductSuccess extends DeleteProductState {}
