import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/utils/app_font_styles.dart';
import 'package:swift_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:swift_mobile_app/features/client/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:swift_mobile_app/features/client/cart/presentation/cubits/check_out_cubit/check_out_cubit.dart';

class CheckoutBottomSheet extends StatefulWidget {
  const CheckoutBottomSheet({super.key});

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? city, street;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("معلومات التسليم", style: AppTextStyles.w600_18),
            const SizedBox(height: 16),
            CustomFormTextField(
              onSaved: (p0) => city = p0,
              title: "المحافظة",

              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 12),
            CustomFormTextField(
              onSaved: (p0) => street = p0,
              title: "مكان التسليم",
              textInputType: TextInputType.text,
            ),
            SizedBox(
              width: double.infinity,
              child: BlocConsumer<CheckOutCubit, CheckOutState>(
                listener: (context, state) {
                  if (state is CheckOutSuccess) {
                    Navigator.pop(context, "refresh");
                    showSuccessMessage('تم إنشاء الطلب بنجاح', context);
                  } else if (state is CheckOutFailure) {
                    showErrorMessage(state.message, context);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    title: state is CheckOutLoading ? "جار الطلب..." : "تاكيد",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        final String address = '$street, $city';

                        context.read<CheckOutCubit>().addOrder(
                          userId: context.read<UserCubit>().currentUser!.id,
                          address: address,
                        );
                      } else {
                        setState(() {
                          autovalidateMode = AutovalidateMode.onUserInteraction;
                        });
                      }
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
