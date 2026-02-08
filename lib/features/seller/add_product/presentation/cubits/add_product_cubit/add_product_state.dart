part of 'add_product_cubit.dart';

 class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

 class AddProductInitial extends AddProductState {}

 class AddProductLoading extends AddProductState {}

 class AddProductFailure extends AddProductState {
  final String errMessage;

  const AddProductFailure(this.errMessage);
}

 class AddProductSuccess extends AddProductState {}
