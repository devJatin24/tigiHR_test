import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/calculator_cubit.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  TextEditingController _controller = TextEditingController();
  late CalculatorCubit _cubit ;


  @override
  void initState() {
    _cubit = BlocProvider.of<CalculatorCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),
      body:BlocConsumer<CalculatorCubit, CalculatorState>(
          builder: (BuildContext context, state) {
            if (state is CalculatorLoaded) {
              return body();
            } else if (state is CalculatorInitial) {
              return body();
            } else if (state is CalculatorLoading) {
              return Stack(
                children: [body(), const Center(child: CircularProgressIndicator(),)],
              );
            } else if (state is CalculatorError) {
              return body();
            }
            //show default screen or access denied screen
            return Container();
          }, listener: (BuildContext context, state) {
        if (state is CalculatorError) {
          if (state.error.isNotEmpty) {
          //show dialog or toast msg
            msg(state.error,error: true);
          }
        } else if (state is CalculatorLoaded) {
          //show dialog or toast msg
          msg(state.msg);
        }
      }),
    );
  }


  body(){
  return  SingleChildScrollView(child:
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            _cubit.add(_controller.text);
          }, child: const Text("Calculate"))

        ],),
    ),);
  }


  msg(String msg, {bool error = false}){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor:error? Colors.red:Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}
