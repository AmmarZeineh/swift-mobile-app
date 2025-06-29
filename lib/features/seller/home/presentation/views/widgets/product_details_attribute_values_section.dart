import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_attribute_dialog.dart';
import 'package:swift_mobile_app/features/seller/home/domain/entities/product_entity.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/cubits/product_attributes_cubit/product_attributes_cubit.dart';
import 'package:swift_mobile_app/features/seller/home/presentation/views/widgets/product_details_row.dart';

class ProductDetailsAttributeValuesSection extends StatelessWidget {
  const ProductDetailsAttributeValuesSection({
    super.key,
    required this.currentProduct,
  });

  final ProductEntity currentProduct;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductAttributesCubit, ProductAttributesState>(
      builder: (context, state) {
        if (state is ProductAttributesSuccess) {
          return Column(
            children: [
              SizedBox(height: 16),
              ...state.data.map(
                (attributeWithValues) => ProductDetailsRow(
                  title: attributeWithValues.attribute.name,
                  value: attributeWithValues.values
                      .map((v) => v.value)
                      .join(', '),
                  onPressed: () {
                    showEditAttributeDialog(
                      context,
                      attributeWithValues.attribute.name,
                      attributeWithValues.values,
                      attributeWithValues.attribute.id,
                      currentProduct,
                    );
                  },
                ),
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
