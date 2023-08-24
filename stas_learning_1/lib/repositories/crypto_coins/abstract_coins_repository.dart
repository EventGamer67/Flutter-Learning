
import 'package:stas_learning_1/repositories/crypto_coins/models/crypto_coin_model.dart';

abstract class AbstractCoinsRepository {
    Future<List<CryptoCoin>> getCoinsList();
}