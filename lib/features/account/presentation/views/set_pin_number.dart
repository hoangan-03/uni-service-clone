import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

class SetPinNumberPage extends StatefulWidget {
  const SetPinNumberPage({super.key});

  @override
  SetPinNumberPageState createState() => SetPinNumberPageState();
}

class SetPinNumberPageState extends State<SetPinNumberPage> {
  final AccountController controller = Get.find<AccountController>();

  @override
  void initState() {
    super.initState();
    controller.pinController.addListener(controller.onPinChanged);
  }

  @override
  void dispose() {
    controller.pinController.removeListener(controller.onPinChanged);
    controller.pinController.dispose();
    controller.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      backgroundColor: appColors!.white,
      appBar: buildAppBar(
          appColors: appColors, context: context, title: S.create_pin),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.enter_pin,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              PinInputField(controller: controller.pinController),
              SizedBox(height: 40),
              Obx(() => Text('PIN: ${controller.pin.value}',
                  style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}

class PinInputField extends StatelessWidget {
  final TextEditingController controller;
  const PinInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      obscureText: true,
      keyboardType: TextInputType.number,
      maxLength: 4,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        counterText: '',
        hintText: '****',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      ),
    );
  }
}
