import 'package:stas_learning_1/features/crypto_coin/crypto_coin.dart';
import 'package:stas_learning_1/features/crypto_coins_list/crypto_list.dart';

final routes = {
  '/': (context) => const CryptoListScreen(title: "dam"),
  '/Coin': (context) => const CryptoCoinScreen(),
};
