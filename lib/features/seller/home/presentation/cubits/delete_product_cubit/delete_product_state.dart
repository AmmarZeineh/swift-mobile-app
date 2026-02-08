part of 'delete_product_cubit.dart';

class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

class DeleteProductInitial extends DeleteProductState {}

class DeleteProductLoading extends DeleteProductState {}

class DeleteProductFailure extends DeleteProductState {
  final String errMessage;

  const DeleteProductFailure(this.errMessage);
}

class DeleteProductSuccess extends DeleteProductState {}
