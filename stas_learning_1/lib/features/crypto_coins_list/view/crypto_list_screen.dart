import 'package:flutter/material.dart';
import 'package:stas_learning_1/features/crypto_coins_list/widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
                thickness: 0.3,
              ),
          itemCount: 30,
          itemBuilder: (context, i) {
            const String coinName = 'BitCoin';
            return const CryptoCoinTile(coinName: coinName);
          }),
    );
  }
}
