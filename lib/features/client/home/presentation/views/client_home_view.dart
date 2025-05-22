import 'package:flutter/material.dart';
import 'package:swift_mobile_app/features/client/home/presentation/views/widgets/client_home_view_body.dart';

class ClientHomeView extends StatelessWidget {
  const ClientHomeView({super.key});
  static const routeName = 'client-home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ClientHomeViewBody()));
  }
}
