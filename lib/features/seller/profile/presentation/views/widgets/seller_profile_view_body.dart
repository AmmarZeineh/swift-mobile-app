// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swift_mobile_app/constants.dart';
import 'package:swift_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:swift_mobile_app/core/helper_functions/show_edit_profile_info_dialog.dart';
import 'package:swift_mobile_app/core/helper_functions/show_log_out_dialog.dart';
import 'package:swift_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:swift_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:swift_mobile_app/core/utils/app_colors.dart';
import 'package:swift_mobile_app/features/seller/auth/data/models/seller_model.dart';
import 'package:swift_mobile_app/features/seller/auth/domain/entity/seller_entity.dart';
import 'package:swift_mobile_app/core/cubits/edit_profile_details_cubit/edit_profile_details_cubit.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/widgets/info_action_button.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/widgets/info_card.dart';
import 'package:swift_mobile_app/features/seller/profile/presentation/views/widgets/profile_info_header.dart';

class SellerProfileViewBody extends StatelessWidget {
  final SellerEntity sellerEntity;

  const SellerProfileViewBody({super.key, required this.sellerEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfileDetailsCubit, EditProfileDetailsState>(
          listener: (context, state) {
            if (state is EditProfileDetailsFailure) {
              showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
            }
          },
        ),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          SellerEntity currentSeller = sellerEntity;

          if (state is UserLoaded) {
            currentSeller = state.user;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProfileInfoHeader(sellerEntity: currentSeller),
                  SizedBox(height: 24.h),
                  Text(
                    'معلومات الملف الشخصي',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  InfoCard(
                    onTap: () {
                      showEditProfileInfo(
                        context,
                        'اسم المتجر',
                        currentSeller.storeName,
                        (value) async {
                          await _updateSellerStoreName(
                            context,
                            currentSeller,
                            value,
                          );
                        },
                        TextInputType.text,
                      );
                    },
                    icon: Icons.store,
                    title: 'اسم المتجر',
                    value: currentSeller.storeName,
                    color: Colors.green,
                  ),
                  SizedBox(height: 12.h),
                  InfoCard(
                    onTap: () {
                      showEditProfileInfo(
                        context,
                        'عنوان المتجر',
                        currentSeller.storeAddress,
                        (value) async {
                          await _updateSellerStoreAddress(
                            context,
                            currentSeller,
                            value,
                          );
                        },
                        TextInputType.text,
                      );
                    },
                    icon: Icons.location_on,
                    title: 'عنوان المتجر',
                    value: currentSeller.storeAddress,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 12.h),
                  InfoCard(
                    onTap: () {
                      showEditProfileInfo(
                        context,
                        'رقم الهاتف',
                        currentSeller.phoneNumber,
                        (value) async {
                          await _updateSellerPhoneNumber(
                            context,
                            currentSeller,
                            value,
                          );
                        },
                        TextInputType.phone,
                      );
                    },
                    icon: Icons.phone,
                    title: 'رقم الهاتف',
                    value: currentSeller.phoneNumber,
                    color: Colors.purple,
                  ),
                  SizedBox(height: 16.h),
                  InfoActionButton(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    onTap: () {
                      showLogoutDialog(context, sellerKey);
                    },
                    color: Colors.red,
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // منع إغلاق الـ dialog بالضغط خارجه
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.primaryColor),
                Spacer(),
                Text('...جار التحديث'),
              ],
            ),
          ),
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _updateSellerStoreName(
    BuildContext context,
    SellerEntity currentSeller,
    String value,
  ) async {
    try {
      // إظهار loading dialog
      _showLoadingDialog(context);

      // بدء عملية التحديث
      await context.read<EditProfileDetailsCubit>().editSellerDetails(
        sellerEntity: currentSeller,
        newData: {'store_name': value},
        columnName: 'user_id',
        columnValue: currentSeller.id,
      );

      // انتظار العملية

      // إخفاء loading dialog
      _hideLoadingDialog(context);

      final editState = context.read<EditProfileDetailsCubit>().state;

      if (editState is EditProfileDetailsSuccess) {
        SellerEntity newSellerEntity = currentSeller.copyWith(storeName: value);

        context.read<UserCubit>().setUser(newSellerEntity);

        await _updateSharedPreferences(newSellerEntity, context);

        showSuccessMessage('تم تحديث اسم المتجر بنجاح', context);

        Navigator.pop(context); // إغلاق dialog التعديل
      } else if (editState is EditProfileDetailsFailure) {
        showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
        Navigator.pop(context); // إغلاق dialog التعديل
      }
    } catch (e) {
      // إخفاء loading dialog في حالة الخطأ
      _hideLoadingDialog(context);
      showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
      Navigator.pop(context); // إغلاق dialog التعديل
    }
  }

  Future<void> _updateSellerStoreAddress(
    BuildContext context,
    SellerEntity currentSeller,
    String value,
  ) async {
    try {
      // إظهار loading dialog
      _showLoadingDialog(context);

      // بدء عملية التحديث
      await context.read<EditProfileDetailsCubit>().editProfileDetails(
        newData: {'address': value},
        columnName: 'id',
        columnValue: currentSeller.id,
      );

      // انتظار العملية
      await Future.delayed(Duration(milliseconds: 500));

      // إخفاء loading dialog
      _hideLoadingDialog(context);

      final editState = context.read<EditProfileDetailsCubit>().state;

      if (editState is EditProfileDetailsSuccess) {
        SellerEntity newSellerEntity = currentSeller.copyWith(
          storeAddress: value,
        );

        context.read<UserCubit>().setUser(newSellerEntity);

        await _updateSharedPreferences(newSellerEntity, context);

        showSuccessMessage('تم تحديث عنوان المتجر بنجاح', context);

        Navigator.pop(context); // إغلاق dialog التعديل
      } else if (editState is EditProfileDetailsFailure) {
        showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
        Navigator.pop(context); // إغلاق dialog التعديل
      }
    } catch (e) {
      // إخفاء loading dialog في حالة الخطأ
      _hideLoadingDialog(context);
      showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
      Navigator.pop(context); // إغلاق dialog التعديل
    }
  }

  Future<void> _updateSellerPhoneNumber(
    BuildContext context,
    SellerEntity currentSeller,
    String value,
  ) async {
    try {
      // إظهار loading dialog
      _showLoadingDialog(context);

      // بدء عملية التحديث
      await context.read<EditProfileDetailsCubit>().editProfileDetails(
        newData: {'phone': value},
        columnName: 'id',
        columnValue: currentSeller.id,
      );

      // انتظار العملية
      await Future.delayed(Duration(milliseconds: 500));

      // إخفاء loading dialog
      _hideLoadingDialog(context);

      final editState = context.read<EditProfileDetailsCubit>().state;

      if (editState is EditProfileDetailsSuccess) {
        SellerEntity newSellerEntity = currentSeller.copyWith(
          phoneNumber: value,
        );

        context.read<UserCubit>().setUser(newSellerEntity);

        await _updateSharedPreferences(newSellerEntity, context);

        showSuccessMessage('تم تحديث رقم الهاتف بنجاح', context);

        Navigator.pop(context); // إغلاق dialog التعديل
      } else if (editState is EditProfileDetailsFailure) {
        showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
        Navigator.pop(context); // إغلاق dialog التعديل
      }
    } catch (e) {
      // إخفاء loading dialog في حالة الخطأ
      _hideLoadingDialog(context);
      showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
      Navigator.pop(context); // إغلاق dialog التعديل
    }
  }

  Future<void> _updateSharedPreferences(
    SellerEntity sellerEntity,
    BuildContext context,
  ) async {
    try {
      SellerModel sellerModel = SellerModel.fromEntity(sellerEntity);
      await Prefs.remove(sellerKey);
      await Prefs.setString(sellerKey, jsonEncode(sellerModel.toJson()));
    } catch (e) {
      log(e.toString());
      showErrorMessage('حدث خطأ ، يرجى المحاولة مرة أخرى', context);
    }
  }
}
