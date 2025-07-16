import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkingHoursScreen extends StatefulWidget {
  @override
  _WorkingHoursScreenState createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  List<Widget> workingHoursEntries = [];

  @override
  void initState() {
    super.initState();
    // Add the first "From" and "To" entry on load
    _addWorkingHourEntry();
  }

  void _addWorkingHourEntry() {
    setState(() {
      workingHoursEntries.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AmPmSelector(),
                SizedBox(width: 10),
                _buildTimeField(context, 'Minute'),
                SizedBox(width: 10),
                _buildColonSeparator(),
                SizedBox(width: 10),
                _buildTimeField(context, 'Hour', maxValue: 12),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AmPmSelector(),
                SizedBox(width: 10),
                _buildTimeField(context, 'Minute'),
                SizedBox(width: 10),
                _buildColonSeparator(),
                SizedBox(width: 10),
                _buildTimeField(context, 'Hour', maxValue: 12),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    });
  }

  Widget _buildColonSeparator() {
    return Column(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ),
        SizedBox(height: 5),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ),
      ],
    );
  }

  Widget _buildTimeField(BuildContext context, String label, {int? maxValue}) {
    return Column(
      children: [
        SizedBox(
          width: 80,
          child: TextFormField(
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              if (maxValue != null) MaxValueFormatter(maxValue),
            ],
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "00",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Color(0xFFE5E7EB)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              filled: true,
              fillColor: Color(0xFFF9FAFB),
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Working Hours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: workingHoursEntries.length,
                itemBuilder: (context, index) => workingHoursEntries[index],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addWorkingHourEntry,
              child: Text('Add Another Working Hour'),
            ),
          ],
        ),
      ),
    );
  }
}

// Assuming AmPmSelector is a previously defined widget
class AmPmSelector extends StatefulWidget {
  @override
  _AmPmSelectorState createState() => _AmPmSelectorState();
}

class _AmPmSelectorState extends State<AmPmSelector> {
  bool isAmSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => setState(() => isAmSelected = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: isAmSelected ? Colors.blue : Colors.grey[300],
            foregroundColor: isAmSelected ? Colors.white : Colors.black,
          ),
          child: Text('AM'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => setState(() => isAmSelected = false),
          style: ElevatedButton.styleFrom(
            backgroundColor: !isAmSelected ? Colors.blue : Colors.grey[300],
            foregroundColor: !isAmSelected ? Colors.white : Colors.black,
          ),
          child: Text('PM'),
        ),
      ],
    );
  }
}

// MaxValueFormatter restricts maximum value for time fields
class MaxValueFormatter extends TextInputFormatter {
  final int maxValue;

  MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    int? newInt = int.tryParse(newValue.text);
    if (newInt == null || newInt <= maxValue) {
      return newValue;
    }
    return oldValue;
  }
}
