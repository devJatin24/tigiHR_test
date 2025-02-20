import 'package:flutter/material.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//Todo convert in statless class and use bloc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(child:
      Column(
        children: [
        TextField(
          controller: _controller,
        ),
       const SizedBox(height: 10,),
        ElevatedButton(onPressed: (){
          add(_controller.text);
        }, child: const Text("Calculate"))

      ],),),
    );
  }

  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    String delimiter = ","; // Default delimiter
    //Todo:For example, "//;\n1;2" where the delimiter is ";" should return 3. and check with negative number

    String cleanedNumbers = numbers.replaceAll("\n", delimiter);
    List<String> numStrings = cleanedNumbers.split(delimiter);

    List<int> nums = [];
    List<int> negatives = [];

    for (String numStr in numStrings) {
      if (numStr.isNotEmpty) { // Handle potential empty strings after splits
        try {
          int num = int.parse(numStr.trim());
          if (num < 0) {
            negatives.add(num);
          }
          nums.add(num);
        } catch (e) {
          throw FormatException("Invalid number format: $numStr");
        }
      }
    }

    if (negatives.isNotEmpty) {
      throw Exception("negative numbers not allowed");
    }

    var result  = nums.fold(0, (sum, num) => sum + num);
    print(result);
    return result;
  }

}
