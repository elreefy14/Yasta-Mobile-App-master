import 'package:flutter/material.dart';
import 'package:yasta/core/helper/cache_helper/cache_helper.dart';
import '../../../../../../core/app_local/app_local.dart';
import '../../../../../../core/componant/custom_multi_select_dropdown_field.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../core/helper/spacing/spacing.dart';
import '../../../../data/models/schedule_model.dart';
import '../../../../logic/auth_cubit/auth_cubit.dart';
import 'from_widget.dart';

class FromAndToWidget extends StatefulWidget {
   List<String> selectedDays;
  final TextEditingController fromHourController;
  final TextEditingController fromMinuteController;
  final TextEditingController toHourController;
  final TextEditingController toMinuteController;
  final VoidCallback onDelete;
   int ?index;

   FromAndToWidget({
    super.key,
    required this.selectedDays,
    required this.fromHourController,
    required this.fromMinuteController,
    required this.toHourController,
    required this.toMinuteController,
    required this.onDelete,  this.index,
  });

  @override
  State<FromAndToWidget> createState() => _FromAndToWidgetState();
}

class _FromAndToWidgetState extends State<FromAndToWidget> {
  final List<String> arabicDays = ['السبت', 'الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة'];
  final List<String> englishDays = [ 'saturday', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday'];
  final Map<String, String> dayMapping = {
    'السبت': 'saturday',
    'الأحد': 'sunday',
    'الإثنين': 'monday',
    'الثلاثاء': 'tuesday',
    'الأربعاء': 'wednesday',
    'الخميس': 'thursday',
    'الجمعة': 'friday',
  };

  List<String> englishSelectedDays = [];
  List<String> selectedDay = [];
  List<String> selectedDay2 = [];

  @override
  void initState() {
    super.initState();
    CacheHelper.saveData(key: "lang",value: "ar");
    print(CacheHelper.getdata(key: "lang").toString());
    print(CacheHelper.getdata(key: "lang").toString() == "ar");
    print("Widget selectedDays (English for DB): ${widget.selectedDays}");
    // Initialize based on the language of `widget.selectedDays`
    bool isArabicDays = widget.selectedDays.isNotEmpty &&
        arabicDays.contains(widget.selectedDays.first);

    if (CacheHelper.getdata(key: "lang").toString() == "ar") {
      // Arabic days were provided
      selectedDay = widget.selectedDays;

      // Convert Arabic days to English for `widget.selectedDays`
      widget.selectedDays = selectedDay.map((arabicDay) {
        return dayMapping[arabicDay] ?? '';
      }).toList();
    } else {
      // English days were provided
      selectedDay2 = widget.selectedDays;

      // Convert English days to Arabic for display
      selectedDay = selectedDay2.map((englishDay) {
        return dayMapping.entries
            .firstWhere((entry) => entry.value == englishDay,
            orElse: () => const MapEntry('', ''))
            .key;
      }).toList();
    }

    // Debug prints
    print("Initialized selectedDay (Arabic): $selectedDay");
    print("Initialized selectedDay2 (English): $selectedDay2");
    print("Widget selectedDays (English for DB): ${widget.selectedDays}");
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomMultiSelectDropdownField2<String>(
          label: '',
          hintText: getLang(context, "Choose the days").toString(),
          selectedValues: CacheHelper.getdata(key: "lang").toString() == "en"? selectedDay2:selectedDay, // Arabic selected days
          items:CacheHelper.getdata(key: "lang").toString() == "en"?englishDays : arabicDays, // Dropdown options in Arabic
          onChanged: (selectedItems) {
            setState(() {
            //  bool isArabic = CacheHelper.getdata(key: "lang").toString() == "ar";

              if (CacheHelper.getdata(key: "lang").toString() == "ar") {
                // Update Arabic selected days
                selectedDay
                  ..clear()
                  ..addAll(selectedItems);

                // Map Arabic days to English for `widget.selectedDays`
                widget.selectedDays = selectedItems.map((day) => dayMapping[day]!).toList();
              } else {
                // Update English selected days
                selectedDay2
                  ..clear()
                  ..addAll(selectedItems);

                // Directly update `widget.selectedDays` with English days
                widget.selectedDays = List.from(selectedItems);
              }

              // Debug prints
              print("Updated selectedDay (Arabic): $selectedDay");
              print("Updated selectedDay2 (English): $selectedDay2");
              print("Widget selectedDays (English for DB): ${widget.selectedDays}");
            });
          },


        ),
        // CustomMultiSelectDropdownField2<String>(
        //   label: '',
        //   hintText: getLang(context, "Choose the days").toString(),
        //   selectedValues: widget.selectedDays, // Already a List<String>
        //   items: getIt<AuthCubit>().items, // Ensure items is also List<String>
        //   onChanged: (selectedItems) {
        //     // Replace the list entirely to avoid concurrent modification issues
        //    setState(() {
        //      widget.selectedDays..clear()..addAll(selectedItems);
        //    });
        //   },
        // ),
        verticalSpace(30),
        FromOrToWidget(
          label: getLang(context, "From").toString(),
          hourController: widget.fromHourController,
          minuteController: widget.fromMinuteController,
        ),
        FromOrToWidget(
          label: getLang(context, "To").toString(),
          hourController: widget.toHourController,
          minuteController: widget.toMinuteController,
        ),
          widget.index==0 ? const SizedBox.shrink() : Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red,),
            onPressed: widget.onDelete,
          ),
        ),
      ],
    );
  }
}
