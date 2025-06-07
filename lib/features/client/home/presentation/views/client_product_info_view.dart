import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/product_info_view_body.dart';

class ClientProductInfoView extends StatelessWidget {
  const ClientProductInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(body: SafeArea(child: ProductInfoViewBody()),);
  }
}