import 'package:flutter/material.dart';

import '../presentation/resources/app_text_style.dart';
import '../presentation/resources/custom_elevated_button.dart';

class GrievanceForm extends StatefulWidget {
  const GrievanceForm({super.key});

  @override
  _GrievanceFormState createState() => _GrievanceFormState();
}

class _GrievanceFormState extends State<GrievanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedSubCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: Card(
        elevation: 5.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                color: Colors.white,
                  child: Container(
                    height: 45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.blue), // Set text color
                      decoration: InputDecoration(
                        labelText: 'Enter your text', // Set label text
                        labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle,    // Set label text color
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color
                        ),
                        focusedBorder: const OutlineInputBorder(
                         // borderSide: BorderSide(color: Colors.orange), // Set outline color when focused
                        ),
                      ),
                    ),
                    ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 1.0), // Set the border color and width
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 45,
                      child: DropdownButtonFormField<String>(
                        value: _selectedSubCategory,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10), // Adjust padding
                          labelText: 'Sub Category',
                          labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle, // Set label color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                        ),
                        style: TextStyle(color: Colors.black), // Set selected value color
                        dropdownColor: Colors.orange, // Set dropdown background color
                        items: ['Sub Category 1', 'Sub Category 2']
                            .map((label) => DropdownMenuItem(
                          child: Center(child: Text(label)), // Center the dropdown items
                          value: label,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a sub category';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 1.0), // Set the border color and width
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      height: 45,
                      child: DropdownButtonFormField<String>(
                        value: _selectedSubCategory,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10), // Adjust padding
                          labelText: 'Sub Category',
                          labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle, // Set label color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.transparent), // Make the Input border transparent
                          ),
                        ),
                        style: TextStyle(color: Colors.black), // Set selected value color
                        dropdownColor: Colors.orange, // Set dropdown background color
                        items: ['Sub Category 1', 'Sub Category 2']
                            .map((label) => DropdownMenuItem(
                          child: Center(child: Text(label)), // Center the dropdown items
                          value: label,
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a sub category';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                  color: Colors.white,
                  child: Container(
                    height: 45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.blue), // Set text color
                      decoration: InputDecoration(
                        labelText: 'Enter your text', // Set label text
                        labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle,    // Set label text color
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color when focused
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                  color: Colors.white,
                  child: Container(
                    height: 45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.blue), // Set text color
                      decoration: InputDecoration(
                        labelText: 'Enter your text', // Set label text
                        labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle,    // Set label text color
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color when focused
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 8,
                  shadowColor: Colors.orange, // Set the shadow color
                  color: Colors.white,
                  child: Container(
                    height: 45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.blue), // Set text color
                      decoration: InputDecoration(
                        labelText: 'Enter your text', // Set label text
                        labelStyle: AppTextStyle.font14penSansExtraboldBlack45TextStyle,    // Set label text color
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange), // Set outline color when focused
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Click Photo'),
                    onTap: () {
                      // Implement photo click functionality
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                CustomElevatedButton(
                  text: 'Post Grienance',
                  onTap: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Posting Grievance...')),
                          );
                        }
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}