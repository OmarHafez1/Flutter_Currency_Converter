import 'dart:convert';

import 'package:currency_converter/CurrencyInput.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String API_KEY = "51a7c9772f10302ec8ec08ce77cf73e3";
late var currency_rates_json;
void main() {
  runApp(
    const MaterialApp(
      title: 'Currency Converter',
      home: HomePage(),
    ),
  );
}

Future<http.Response> fetchRates() {
  return http.get(Uri.parse(
      'http://api.exchangeratesapi.io/v1/latest?access_key=$API_KEY'));
}

double calculate(double amount, Currency from, Currency to) {
  return currency_rates_json["rates"][to.code.toUpperCase()] *
      amount /
      currency_rates_json["rates"][from.code.toUpperCase()];
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CurrencyInput input1 = CurrencyInput(),
        input2 = CurrencyInput(
          isEnabled: false,
        );
    return FutureBuilder(
        future: fetchRates(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            currency_rates_json = json.decode(snapshot.data!.body);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Convert",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    input1,
                    const SizedBox(
                      height: 40,
                    ),
                    input2,
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 30,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 23, vertical: 10)),
                          onPressed: () {
                            double? val = double.tryParse(input1.getText);
                            if (val != null) {
                              input2.setText(
                                calculate(
                                  val,
                                  input1.getCurrency,
                                  input2.getCurrency,
                                ).toString(),
                              );
                            }
                          },
                          child: Text(
                            "Calculate",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
