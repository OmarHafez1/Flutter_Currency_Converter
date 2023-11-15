import 'package:currency_converter/FlagCurrencyButton.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyInput extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  bool isEnabled;
  Currency currency = CurrencyService().findByCode('egp')!;
  String get getText => textEditingController.text;
  Currency get getCurrency => currency;
  late void Function(String) setText;
  late void Function(String) setCurrency;
  CurrencyInput({
    this.isEnabled = true,
    super.key,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  @override
  Widget build(BuildContext context) {
    widget.setText = (String value) {
      setState(
        () {
          double? tmp = double.tryParse(value);
          assert(tmp != null);
          widget.textEditingController.text =
              double.parse(tmp!.toStringAsFixed(4)).toString();
        },
      );
    };

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Row(
          children: [
            FlagCurrencyButton(
              CurrentCurrency: widget.currency,
              CurrencyChanged: (Currency cur) {
                setState(() {
                  widget.currency = cur;
                });
              },
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
              child: TextFormField(
                controller: widget.textEditingController,
                enabled: widget.isEnabled,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) {
                      return newValue.text.isEmpty
                          ? newValue
                          : double.tryParse(newValue.text) == null
                              ? oldValue
                              : newValue;
                    },
                  ),
                ],
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              widget.currency.symbol,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
