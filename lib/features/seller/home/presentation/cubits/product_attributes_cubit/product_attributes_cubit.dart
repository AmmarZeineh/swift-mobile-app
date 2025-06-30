import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/core/entities/product_attribute_wit_values_entity.dart';
import 'package:swift_mobile_app/core/errors/failure.dart';
import 'package:swift_mobile_app/features/seller/home/domain/repos/seller_home_repo.dart';

part 'product_attributes_state.dart';

class ProductAttributesCubit extends Cubit<ProductAttributesState> {
  ProductAttributesCubit(this.repository) : super(ProductAttributesInitial());

  final SellerHomeRepo repository;

  bool _isLoading = false;

  Future<void> fetchAttributesWithValues(int categoryId, int productId) async {
    if (_isLoading) return;

    _isLoading = true;
    emit(ProductAttributesLoading());

    try {
      final attributesResult = await repository.getProductAttributes(
        categoryId,
      );

      if (attributesResult.isLeft()) {
        _isLoading = false;
        emit(
          ProductAttributesFailure(
            attributesResult
                .swap()
                .getOrElse(() => ServerFailure("Error"))
                .toString(),
          ),
        );
        return;
      }

      final attributes = attributesResult.getOrElse(() => []);

      final valuesResult = await repository.getProductAttributeValues(
        productId,
      );

      if (valuesResult.isLeft()) {
        _isLoading = false;
        emit(
          ProductAttributesFailure(
            valuesResult
                .swap()
                .getOrElse(() => ServerFailure("Error"))
                .toString(),
          ),
        );
        return;
      }

      final values = valuesResult.getOrElse(() => []);

      final Map<int, List<ProductAttributeValueEntity>> groupedValues = {};

      for (var value in values) {
        groupedValues.putIfAbsent(value.attributeId, () => []);
        groupedValues[value.attributeId]!.add(value);
      }

      final mergedData =
          attributes.map((attribute) {
            return ProductAttributeWithValues(
              attribute: attribute,
              values: groupedValues[attribute.id] ?? [],
            );
          }).toList();

      _isLoading = false;
      emit(ProductAttributesSuccess(mergedData));
    } catch (e) {
      _isLoading = false;
      emit(ProductAttributesFailure(e.toString()));
    }
  }
}
