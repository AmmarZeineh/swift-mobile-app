// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:swift_mobile_app/features/client/home/domain/entities/product_entity.dart';
// import 'package:swift_mobile_app/features/client/product_details/presentation/cubits/product_attribute_valuecubit/product_attribute_value_cubit.dart';
// import 'package:swift_mobile_app/features/client/product_details/presentation/views/widgets/product_attribut_card.dart';

// class ProductAttributesSheet extends StatefulWidget {
//   const ProductAttributesSheet({super.key, required this.product});
//   final ProductEntity product;

//   @override
//   State<ProductAttributesSheet> createState() => _ProductAttributesSheetState();
// }

// class _ProductAttributesSheetState extends State<ProductAttributesSheet> {
//   @override
//   void initState() {
//     context.read<ProductAttributesCubit>().fetchAttributesWithValues(
//       widget.product.id,
//       widget.product.categoryId,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: SizedBox(
//         height: 300, 
//         child: BlocBuilder<ProductAttributesCubit, ProductAttributesState>(
//           builder: (context, state) {
//             if (state is ProductAttributesSuccess) {
//               return ListView.builder(
//                 itemCount: state.attributesWithValues.length,
//                 itemBuilder: (context, index) {
//                   final item = state.attributesWithValues[index];
//                   return SimpleProductAttributeCard(attributeWithValues: item);
//                 },
//               );
//             } else if (state is ProductAttributesFailure) {
//               return Center(child: Text('حدث خطأ: ${state.errMessage}'));
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       ),
//     );
//   }
// }