import 'package:flutter/material.dart';
import 'package:tokihakanenari/custom_card.dart';
import 'package:tokihakanenari/income_counter.dart';
import 'package:tokihakanenari/saving_accounts.dart';

void main() {
  runApp(const TokiHaKaneNari());
}

class TokiHaKaneNari extends StatelessWidget {
  const TokiHaKaneNari({super.key});

  final String appTitle = '時は金なり';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(
        appTitle: appTitle,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String appTitle;

  const MainPage({super.key, required this.appTitle});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    Size deviceSize = queryData.size;
    Orientation deviceOrientation = queryData.orientation;

    return Column(
      children: [
        CustomCard(deviceSize: deviceSize, deviceOrientation: deviceOrientation, cardContent: IncomeCounter()),
        Transform(
          transform: Matrix4.rotationX(2),
          child: CustomCard(deviceSize: deviceSize, deviceOrientation: deviceOrientation, cardContent: SavingAccounts()),
        ),
      ],
    );
  }
}
