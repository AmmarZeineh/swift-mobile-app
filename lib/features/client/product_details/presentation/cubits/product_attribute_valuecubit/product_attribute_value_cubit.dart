import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/attribute_with_value.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/entities/product_attribute_value_entity.dart';
import 'package:swift_mobile_app/features/client/product_details/domain/repo/product_details_repo.dart';

part 'product_attribute_value_state.dart';
class ProductAttributesCubit extends Cubit<ProductAttributesState> {
  ProductAttributesCubit(this.repository) : super(ProductAttributesInitial());

  final ProductDetailsRepo repository; // استبدل باسم الـ repository الخاص بك

  // جلب attributes للـ category
    Future<void> fetchAttributesWithValues(int categoryId, int productId) async {
    emit(ProductAttributesLoading());
    
    // جلب الـ attributes
    var attributesResult = await repository.getProductAttributes(categoryId);
    
    attributesResult.fold(
      (l) => emit(ProductAttributesFailure(l.message)),
      (attributes) async {
        // جلب القيم
        var valuesResult = await repository.getProductAttributeValues(productId);
        
        valuesResult.fold(
          (l) => emit(ProductAttributesFailure(l.message)),
          (values) {
            // دمج البيانات
            Map<int, List<ProductAttributeValueEntity>> groupedValues = {};
            
            // تجميع القيم حسب الـ attribute_id
            for (var value in values) {
              if (groupedValues[value.attributeId] == null) {
                groupedValues[value.attributeId] = [];
              }
              groupedValues[value.attributeId]!.add(value);
            }
            
            // إنشاء البيانات المدموجة
            List<ProductAttributeWithValues> mergedData = attributes.map((attribute) {
              return ProductAttributeWithValues(
                attribute: attribute,
                values: groupedValues[attribute.id] ?? [],
              );
            }).toList();
            
            emit(ProductAttributesSuccess(mergedData));
          },
        );
      },
    );
  }
}
