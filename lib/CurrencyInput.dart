import 'package:currency_converter/FlagCurrencyButton.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Currency currency = CurrencyService().findByCode('usd')!;

class CurrencyInput extends StatefulWidget {
  const CurrencyInput({
    super.key,
  });

  @override
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  @override
  Widget build(BuildContext context) {
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
              CurrentCurrency: currency,
              CurrencyChanged: (Currency cur) {
                setState(() {
                  currency = cur;
                });
              },
            ),
            const SizedBox(
              width: 4,
            ),
            Flexible(
              child: TextFormField(
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
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              currency.symbol,
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
