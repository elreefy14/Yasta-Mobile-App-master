import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmPmSelector extends StatefulWidget {
  final ValueChanged<bool> onChanged; // Add a callback to notify the parent

  const AmPmSelector({Key? key, required this.onChanged}) : super(key: key);

  @override
  _AmPmSelectorState createState() => _AmPmSelectorState();
}

class _AmPmSelectorState extends State<AmPmSelector> {
  bool isAmSelected = true; // Track if AM is selected

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey,
          width: 2.w,
        ),
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                isAmSelected = true; // Set AM as selected
              });
              widget.onChanged(true); // Notify parent with AM selected
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isAmSelected ? Colors.green : Colors.white,
              foregroundColor: isAmSelected ? Colors.white : Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              shape: const RoundedRectangleBorder(),
            ),
            child: Text('AM'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isAmSelected = false; // Set PM as selected
              });
              widget.onChanged(false); // Notify parent with PM selected
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !isAmSelected ? Colors.green : Colors.white,
              foregroundColor: !isAmSelected ? Colors.white : Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              shape: const RoundedRectangleBorder(),
            ),
            child: Text('PM'),
          ),
        ],
      ),
    );
  }
}
