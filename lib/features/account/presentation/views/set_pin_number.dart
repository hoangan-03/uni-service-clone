import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/pin_number_app_bar.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
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
    controller.pinController.addListener(controller.onPinCreated);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildPinNumberAppBar(context, controller,true),
      body: GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller) {
          return Container(
            color: appColors?.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).enter_pin,
                  style: AppTextStyle.regular14()
                      .copyWith(color: appColors?.secondary),
                ),
                const SizedBox(height: 32),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: index < controller.pin.value.length
                                  ? null
                                  : Border.all(
                                      color: appColors!.gray, width: 1),
                              color: index < controller.pin.value.length
                                  ? appColors?.primary
                                  : appColors?.transparent,
                            ),
                          ),
                        );
                      }),
                    )),
                const SizedBox(height: 32),
                SizedBox(
                  height: 0,
                  width: 0,
                  child: TextField(
                    controller: controller.pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    autofocus: true,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
