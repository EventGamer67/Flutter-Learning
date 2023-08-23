import 'package:flutter/material.dart';
import 'package:stas_learning_1/features/crypto_coins_list/widgets/widgets.dart';
import 'package:stas_learning_1/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:stas_learning_1/repositories/crypto_coins/models/crypto_coin_model.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

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
      body: _cryptoCoinsList == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              separatorBuilder: (context, index) => const Divider(
                    thickness: 0.3,
                  ),
              itemCount: _cryptoCoinsList!.length,
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];
                return CryptoCoinTile(coin: coin);
              }),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
    setState(() {});
  }
}
