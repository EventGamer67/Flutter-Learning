import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stas_learning_1/repositories/crypto_coins/models/crypto_coin_model.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    final respone = await Dio().get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,DASH,SOL,DAI&tsyms=USD&e=Coinbase&extraParams=your_app_name");
    debugPrint(respone.toString());

    final data = respone.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData =
          (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imageURL = usdData['IMAGEURL'];
      return CryptoCoin(
          name: e.key,
          priceUSD: price,
          imageURL: "https://cryptocompare.com/$imageURL");
    }).toList();

    return cryptoCoinsList;
  }
}
