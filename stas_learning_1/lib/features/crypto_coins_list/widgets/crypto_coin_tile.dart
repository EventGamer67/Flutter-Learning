import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({
    super.key,
    required this.coinName,
  });
  
  final String coinName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(
        "assets/svg/token.svg",
        height: 35,
        width: 35,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      title: Text(
        'BitCoin',
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        "пошел нахуй",
        style: theme.textTheme.labelSmall,
      ),
      onTap: () {
        Navigator.of(context).pushNamed('/Coin', arguments: coinName);
      },
    );
  }
}