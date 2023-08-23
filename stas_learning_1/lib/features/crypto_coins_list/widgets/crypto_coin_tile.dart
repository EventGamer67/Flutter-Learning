import 'package:flutter/material.dart';
import 'package:stas_learning_1/repositories/crypto_coins/models/crypto_coin_model.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coin,
  });
  
  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(
        coin.imageURL,
        height: 35,
        width: 35,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(
        coin.name,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        "${coin.priceUSD} USD",
        style: theme.textTheme.labelSmall,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/Coin', arguments: coin);
      },
    );
  }
}