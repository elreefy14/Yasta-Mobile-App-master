import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';

import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/custom_dropdown_field_with_label.dart';
import '../../../../../../core/componant/custom_multi_select_dropdown_field.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../../../core/theme/text_styles.dart';

class ServicesAndAvailableBrandWidget extends StatefulWidget {
  const ServicesAndAvailableBrandWidget({super.key});

  @override
  State<ServicesAndAvailableBrandWidget> createState() =>
      _ServicesAndAvailableBrandWidgetState();
}

class _ServicesAndAvailableBrandWidgetState
    extends State<ServicesAndAvailableBrandWidget> {
  void initState() {
    // TODO: implement initState
    getIt<AuthCubit>().getServices();
    getIt<AuthCubit>().getAllModels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is GetServicesSuccessState) {
              getIt<AuthCubit>().workshopServices = state.data!.data!
                  .map((e) => {'name': e.name!, 'id': e.id.toString()})
                  .toList();

            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return CustomMultiSelectDropdownField<String>(
              label: getLang(context, "Services").toString(),
              hintText: getLang(context, "Choose your service").toString(),
              selectedValues: getIt<AuthCubit>().selectedWorkshopServices,
              items: getIt<AuthCubit>()
                  .workshopServices
                  .map((item) => item['name']!)
                  .toList(),
              onChanged: (selectedItems) {
                getIt<AuthCubit>().workshopServicesList = getIt<AuthCubit>()
                    .workshopServices
                    .where((item) => selectedItems.contains(item['name'])) // Match based on 'name'
                    .map((item) => item['id']!) // Extract 'id'
                    .toList();

                // getIt<AuthCubit>().workshopServicesList.add(selectedItems.toString());
                print("Selected items: $selectedItems");
                print(getIt<AuthCubit>().workshopServicesList);
              },
            );
            // return CustomDropdownField(
            //   isMandatory: true,
            //   label: getLang(context, "Services").toString(),
            //   hintText: getLang(context, "Choose your service").toString(),
            //   items: AuthCubit
            //       .get(context)
            //       .workshopServices,
            //
            // );
          },
        ),
        verticalSpace(40),
        Text(
          getLang(context, "Available brands").toString(),
          style: TextStyles.gray950FS18FW500TextStyle,
        ),
        verticalSpace(20),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is GetAllModelsSuccessState) {
              getIt<AuthCubit>().allModels = state.data!.data!
                  .map((e) => {'name': e.name!, 'id': e.id.toString()})
                  .toList();
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return CustomMultiSelectDropdownField<String>(
              label: getLang(context, "Brand").toString(),
              hintText: getLang(context, "Choose the brands available to you").toString(),
              selectedValues: getIt<AuthCubit>().selectedAllModel,
              items: getIt<AuthCubit>()
                  .allModels
                  .map((item) => item['name']!)
                  .toList(),
              onChanged: (selectedItems) {
                getIt<AuthCubit>().allModelsList = getIt<AuthCubit>()
                    .allModels
                    .where((item) => selectedItems.contains(item['name'])) // Match based on 'name'
                    .map((item) => item['id']!) // Extract 'id'
                    .toList();

                // getIt<AuthCubit>().workshopServicesList.add(selectedItems.toString());
                print("Selected items: $selectedItems");
                print(getIt<AuthCubit>().allModelsList);
              },
            );
            // return CustomDropdownField(
            //   isMandatory: true,
            //   label: getLang(context, "Services").toString(),
            //   hintText: getLang(context, "Choose your service").toString(),
            //   items: AuthCubit
            //       .get(context)
            //       .workshopServices,
            //
            // );
          },
        ),
        // CustomDropdownField(
        //   isMandatory: true,
        //   label: getLang(context, "Brand").toString(),
        //   hintText:
        //       getLang(context, "Choose the brands available to you").toString(),
        //   items: getIt<AuthCubit>().workshopBrands,
        //   onChanged: (String? value) {
        //     getIt<AuthCubit>().workshopBrandValue = value;
        //   },
        // ),
      ],
    );
  }
}
