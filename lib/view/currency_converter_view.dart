import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/currency_view_model.dart';
import 'auto_complete_widget.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CurrencyViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.black,
        elevation: 30,
      ),
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Display grid view when screen width is greater than 600 (for web)
            return _buildCurrencyList(context, viewModel, isGridView: true);
          } else {
            // Display list view for mobile devices
            return _buildCurrencyList(context, viewModel, isGridView: false);
          }
        },
      ),
    );
  }

  Widget _buildCurrencyList(BuildContext context, CurrencyViewModel viewModel, {required bool isGridView}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) => viewModel.updateAmount(double.tryParse(value) ?? 0),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Amount',
              labelStyle: TextStyle(color: Colors.green), // Label text color
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Input field border color when focused
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Input field border color when not focused
              ),
            ),
            style: const TextStyle(color: Colors.pinkAccent), // Text color of input
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AutocompleteWidget(
            options: viewModel.currencies.map((currency) => currency.code).toList(),
            onChange: viewModel.updateCountry,
            selectedCurrency: viewModel.getSelectedCurrency().code,
          ),
        ),
        Expanded(
          child: isGridView ? _buildGridView(viewModel) : _buildListView(viewModel),
        ),
      ],
    );
  }

  Widget _buildListView(CurrencyViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.conversions.length,
      itemBuilder: (context, index) {
        final conversion = viewModel.conversions[index];
        return ListTile(
          title: Row(
            children: [
              Text(conversion.currency.code, style: const TextStyle(color: Color(0xffc651ff))),
              const Text(' : ', style: TextStyle(color: Colors.white)),
              Text('${conversion.amount}', style: const TextStyle(color: Color(0xff3cffa0)))
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView(CurrencyViewModel viewModel) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 8.0,
      ),
      itemCount: viewModel.conversions.length,
      itemBuilder: (context, index) {
        final conversion = viewModel.conversions[index];
        return Card(
          color: Colors.lightBlue,
          child: ListTile(
            title: Center(
                child: Text(
              '${conversion.currency.code}: ${conversion.amount}',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
        );
      },
    );
  }
}
