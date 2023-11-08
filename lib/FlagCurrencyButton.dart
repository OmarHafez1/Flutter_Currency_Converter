import 'package:country_flags/country_flags.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

class FlagCurrencyButton extends StatelessWidget {
  final Currency CurrentCurrency;
  final Function(Currency) CurrencyChanged;
  const FlagCurrencyButton({
    required this.CurrentCurrency,
    required this.CurrencyChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      onPressed: () {
        showCurrencyPicker(
          context: context,
          showFlag: true,
          showSearchField: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          favorite: [],
          onSelect: (Currency currency) {
            CurrencyChanged(currency);
          },
        );
      },
      child: Row(
        children: [
          CountryFlag.fromCountryCode(
            CurrentCurrency.code.substring(0, 2),
            height: 37,
            width: 50,
            borderRadius: 8,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            CurrentCurrency.code.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
