import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_dropdown_field_with_label.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../model/get_workshop_byId_response.dart';

class BrandAndModelSelector extends StatefulWidget {
  const BrandAndModelSelector({super.key, required this.brands});

  final List<Brands> brands;

  @override
  _BrandAndModelSelectorState createState() => _BrandAndModelSelectorState();
}

class _BrandAndModelSelectorState extends State<BrandAndModelSelector> {
  String? selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(context, "Available brands"),
        verticalSpace(20),
        _buildBrandDropdown(context),
        verticalSpace(20),
        _buildModelsText(context),
        verticalSpace(10),
        _buildModelList(),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, String key) {
    return Text(
      getLang(context, key).toString(),
      style: TextStyles.gray950FS18FW500TextStyle,
    );
  }

  Widget _buildBrandDropdown(BuildContext context) {
    return CustomDropdownField(
      borderSide: const BorderSide(
        color: AppColors.gray300,
      ),
      fillColor: AppColors.whiteColor,
      label: getLang(context, "Brand").toString(),
      hintText: getLang(context, "Choose the brands available to you").toString(),
      items: widget.brands.map((brand) => brand.brandName!).toList(),
      value: selectedBrand,
      onChanged: (value) {
        setState(() {
          selectedBrand = value;
        });
      },
    );
  }

  Widget _buildModelsText(BuildContext context) {
    if (selectedBrand == null) {
      return const SizedBox.shrink();
    }

    return Text(
      "${getLang(context, "Models").toString()} $selectedBrand ${getLang(context, "Available").toString()} : ",
      style: TextStyles.gray950FS14FW600CairoTextStyle,
    );
  }

  Widget _buildModelList() {
    if (selectedBrand == null) {
      return const SizedBox.shrink();
    }

    final selectedBrandModels = widget.brands
        .firstWhere(
          (brand) => brand.brandName == selectedBrand,
      orElse: () => Brands(brandName: '', carModels: []),
    )
        .carModels;

    if (selectedBrandModels!.isEmpty) {
      return Text(
        getLang(context, "No models available").toString(),
        style: TextStyles.gray800FS16FW500CairoTextStyle,
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedBrandModels.length,
      itemBuilder: (context, index) {
        final model = selectedBrandModels[index];
        return _buildModelItem(model.name!);
      },
    );
  }

  Widget _buildModelItem(String modelName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6.w,
            height: 2.h,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColors.gray800,
            ),
          ),
          horizontalSpace(10),
          Expanded(
            child: Text(
              modelName,
              style: TextStyles.gray800FS16FW500CairoTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
