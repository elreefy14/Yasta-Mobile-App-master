import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasta/core/app_local/app_local.dart';
import 'package:yasta/core/componant/custom_dropdown_field_with_label.dart';
import 'package:yasta/core/helper/spacing/spacing.dart';
import 'package:yasta/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:yasta/features/my_car_screen/logic/model/show_car_model.dart';
import '../../../../../../core/di/dependency_injection.dart';

class CarSelectionData extends StatefulWidget {
  CarSelectionData({super.key, this.carResponse});

  Data? carResponse;

  @override
  State<CarSelectionData> createState() => _CarSelectionDataState();
}

class _CarSelectionDataState extends State<CarSelectionData> {
  @override
  void initState() {
    // TODO: implement initState
    getIt<AuthCubit>().getBrands();
    print(widget.carResponse?.year?.year);
    getIt<AuthCubit>().userBrandValue = widget.carResponse?.brand?.name;
    getIt<AuthCubit>().userModelValue = widget.carResponse?.model?.name;
    getIt<AuthCubit>().userYearValue = widget.carResponse?.year?.year;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              previous != current && current is GetBrandsSuccessState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetBrandsSuccessState) {
              getIt<AuthCubit>().brandList = state.data!.data!
                  .map((e) => {'name': e.name!, 'id': e.id.toString()})
                  .toList();
              getIt<AuthCubit>().userBrandValue =
                  widget.carResponse?.brand?.name ??
                      getIt<AuthCubit>().brandList[0]['name'];

              getIt<AuthCubit>().getModels(
                  brandId: widget.carResponse?.brand?.id.toString() ??
                      state.data!.data![0].id.toString());
            }
          },
          builder: (context, state) {
            return CustomDropdownField(
              items: getIt<AuthCubit>()
                  .brandList
                  .map((item) => item['name']!)
                  .toList(),
              onChanged: (String? value) {
                // Find the map entry that matches the selected name
                final selectedBrand = getIt<AuthCubit>()
                    .brandList
                    .firstWhere((item) => item['name'] == value);

                // Set the selected brand value and call getModels with the brand id
                getIt<AuthCubit>().userBrandValue = value;
                getIt<AuthCubit>().getModels(brandId: selectedBrand['id']!);
              },
              label: getLang(context, "Brand:").toString(),
              hintText: "تويوتا",
              value: getIt<AuthCubit>().userBrandValue,
            );
          },
        ),
        verticalSpace(20),
        BlocConsumer<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              previous != current && current is GetModelsSuccessState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetModelsSuccessState) {
              getIt<AuthCubit>().modelList = state.data!.data!
                  .map((e) => {'name': e.name!, 'id': e.id.toString()})
                  .toList();
              getIt<AuthCubit>().userModelValue =
                  getIt<AuthCubit>().modelList[0]['name'];
              getIt<AuthCubit>()
                  .getYears(modelId: state.data!.data![0].id.toString());
            }
          },
          builder: (context, state) {
            return CustomDropdownField(
              items: getIt<AuthCubit>()
                  .modelList
                  .map((item) => item['name']!)
                  .toList(),
              onChanged: (String? value) {
                // Find the map entry that matches the selected name
                final selectedModel = getIt<AuthCubit>()
                    .modelList
                    .firstWhere((item) => item['name'] == value);

                // Set the selected brand value and call getModels with the brand id
                getIt<AuthCubit>().userModelValue = value;
                getIt<AuthCubit>().getModels(brandId: selectedModel['id']!);
              },
              label: getLang(context, "Model:").toString(),
              hintText: "تويوتا",
              value: getIt<AuthCubit>().userModelValue,
            );
          },
        ),
        verticalSpace(20),
        BlocConsumer<AuthCubit, AuthState>(
          buildWhen: (previous, current) =>
              previous != current && current is GetYearsSuccessState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is GetYearsSuccessState) {
              getIt<AuthCubit>().yearList = state.data!.data!
                  .map((e) => {'year': e.year!, 'id': e.id.toString()})
                  .toList();
              if (widget.carResponse?.year?.year!=null) {
                getIt<AuthCubit>().userYearValue =
                // getIt<AuthCubit>()
                //         .yearList
                //         .contains(widget.carResponse?.year?.year)
                //     ?
                widget.carResponse?.year?.year!;
                    // : getIt<AuthCubit>().yearList[0]['year'];
              } else {
                getIt<AuthCubit>().userYearValue =
                    getIt<AuthCubit>().yearList[0]['year'];
              }
            }
          },
          builder: (context, state) {
            return CustomDropdownField(
              items: getIt<AuthCubit>()
                  .yearList
                  .map((item) => item['year']!)
                  .toList(),
              onChanged: (String? value) {
                getIt<AuthCubit>().userYearValue = value;
              },
              label: getLang(context, "Year of manufacture:").toString(),
              hintText: "تويوتا",
              value: getIt<AuthCubit>().userYearValue,
            );
          },
        ),
      ],
    );
  }
}
