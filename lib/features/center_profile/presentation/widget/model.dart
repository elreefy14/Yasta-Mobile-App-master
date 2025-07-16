import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/di/dependency_injection.dart';
import 'package:yasta/core/helper/app_color/app_color.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/update_workshop_center_profile/data/logic/update_center_cubit.dart';
import 'package:yasta/features/workshop_profile/model/get_workshop_byId_response.dart';

import '../../../../core/theme/text_styles.dart';

class ModelCatloge extends StatelessWidget {
  ModelCatloge({super.key, required this.data});

  final List<Brands> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getLang(context, "Available brands:").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        verticalSpace(20.h),
        BrandsWidget(parsedBrands: data),
      ],
    );
  }
}
// List<Brands> parseBrands(Brands brands) {
//   final parsedBrands = <Brands>[];
//
//   brands.forEach((key, value) {
//     parsedBrands.add(Brands(
//       brandName: value.brandName ?? key,
//       carModels: value.carModels?.map((e) => e.name ?? "").toList() ?? [],
//     ));
//   });
//
//   return parsedBrands;
// }

class Brand {
  final String name;
  final List<String> models;

  Brand({required this.name, required this.models});
}

class BrandsWidget extends StatefulWidget {
  final List<Brands> parsedBrands;

  const BrandsWidget({required this.parsedBrands, Key? key}) : super(key: key);

  @override
  State<BrandsWidget> createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    getIt<UpdateCenterCubit>().selectedAllModel.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.grey[300],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    getLang(context, "Brand:").toString(),
                    style: TextStyles.gray950FS18FW500TextStyle,
                  ),
                ),
              ),
              const VerticalDivider(color: Colors.red),
              Expanded(
                child: Center(
                  child: Text(
                    getLang(context, "Model:").toString(),
                    style: TextStyles.gray950FS18FW500TextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: widget.parsedBrands.map((brand) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            brand.brandName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 40.h,
                        width: 2.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: brand.carModels!.map((model) {
                            getIt<UpdateCenterCubit>().selectedAllModel.add(model.name.toString());
                            return Text(
                              "${model.name} -",
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
