import 'package:flutter/material.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
   CustomDropdownButtonWidget({super.key});

  final List<String> _options = ['Option 1', 'Option 2', 'Option 3'];
  final String? _selectedValue='Option 1';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      hint: Text('Select an option'),
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: 'Options',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (String? newValue) {
          // _selectedValue = newValue;
      },
      items: _options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
