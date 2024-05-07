import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'repository/currency_repository.dart';
import 'service/currency_service.dart';
import 'view/currency_converter_view.dart';
import 'viewModel/currency_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final service = CurrencyService();
    final repository = CurrencyRepository(service);
    final viewModel = CurrencyViewModel(repository);

    runApp(MyApp(viewModel));
  }, (error, stack) {
    debugPrint("ERROR - some unexpected error occured -> $error, $stack");
  });
}

class MyApp extends StatelessWidget {
  final CurrencyViewModel viewModel;

  const MyApp(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (_) => viewModel,
    child: const MaterialApp(
      home: CurrencyConverterView(),
    ),
  );
}

}
