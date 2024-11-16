import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

class DepositPage extends BaseGetView<DepositController> {
  const DepositPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Nạp thẻ",
        appColors: appColors,
        hasBackButton: true,
      ),
      backgroundColor: appColors!.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          _buildAmountInput(appColors),
          const SizedBox(height: 20),
          _buildPresetAmountButtons(appColors),
          const SizedBox(height: 20),
          _buildContinueButton(appColors),
        ],
      ),
    );
  }

  Widget _buildAmountInput(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.amountController,
                        keyboardType: TextInputType.number,
                        style: AppTextStyle.bold18().copyWith(
                          color: appColors?.secondary,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0',
                        ),
                        onChanged: (value) {
                          controller.updateAmount(value);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.clearAmount();
                      },
                      child: Icon(Icons.clear, color: appColors?.gray),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số tiền hiện tại',
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '99.999 đ',
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPresetAmountButtons(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildPresetAmountButton(appColors, '50.000'),
          _buildPresetAmountButton(appColors, '100.000'),
          _buildPresetAmountButton(appColors, '200.000'),
          _buildPresetAmountButton(appColors, '500.000'),
          _buildPresetAmountButton(appColors, '1.000.000'),
          _buildPresetAmountButton(appColors, '2.000.000'),
        ],
      ),
    );
  }

  Widget _buildPresetAmountButton(AppColors? appColors, String amount) {
    return SizedBox(
      width: 80,
      child: OutlinedButton(
        onPressed: () {
          controller.addAmount(amount);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          backgroundColor: appColors?.white,
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          amount,
          style: AppTextStyle.bold12().copyWith(
            color: appColors?.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 6),
            backgroundColor: appColors?.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Tiếp tục',
            style: AppTextStyle.bold12().copyWith(color: appColors?.white),
          ),
        ),
      ),
    );
  }
}
