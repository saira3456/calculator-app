import 'package:flutter/material.dart';

class MaleScreen extends StatefulWidget {
  const MaleScreen({super.key});
  @override
  State<MaleScreen> createState() => _MaleScreenState();
}

class _MaleScreenState extends State<MaleScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (formKey.currentState?.validate() == true) {
      formKey.currentState?.save();
    }
  }

  TextEditingController heightController = TextEditingController(text: '');
  TextEditingController weightController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Male'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Enter Height and Weight",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 100, right: 100),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your Height',
                            suffixText: 'In meters',
                          ),
                          controller: heightController,
                          validator: (value) {
                            if (value == null || value.isEmpty == true) {
                              return 'Please enter your Height';
                            }
                            double height = double.tryParse(value) ?? 0;
                            if (height < 50) {
                              return 'Invalid Height';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your Weight',
                            suffixText: 'In Kilograms',
                          ),
                          controller: weightController,
                          validator: (value) {
                            if (value == null || value.isEmpty == true) {
                              return 'Please enter your Weight';
                            }
                            double weight = double.tryParse(value) ?? 0;
                            if (weight < 10) {
                              return 'Invalid Weight';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              double weight =
                                  double.tryParse(weightController.text) ?? 0;
                              double height =
                                  double.tryParse(heightController.text) ?? 0;
                              double bmi = calculateBMI(height, weight);
                              String bmiCategory = getBMICategory(bmi);
                              showGeneralDialog(
                                context: context,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: const EdgeInsets.all(20),
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Your BMI is ${bmi.toStringAsFixed(3)}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Result: $bmiCategory',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                barrierDismissible: true,
                                barrierLabel: 'bmiResult',
                              );
                            }
                          },
                          child: const Text('Calculate'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Image.network(
                      'https://static.vecteezy.com/system/resources/previews/005/905/467/non_2x/bmi-classification-chart-measurement-man-set-male-body-mass-index-infographic-with-weight-status-from-underweight-to-severely-obese-medical-body-mass-control-graph-eps-illustration-vector.jpg'))),
        ],
      ),
    );
  }

  double calculateBMI(double height, double weight) {
    double bmi = weight / (height * height);
    return bmi;
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal Weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }
}
