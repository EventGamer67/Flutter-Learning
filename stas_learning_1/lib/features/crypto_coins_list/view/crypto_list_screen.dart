
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stas_learning_1/features/crypto_coins_list/bloc/crypto_list_bloc.dart';
import 'package:stas_learning_1/repositories/crypto_coins/crypto_coins.dart';

import '../widgets/crypto_coin_tile.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
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
        body: RefreshIndicator(
          onRefresh: () {
            final completer = Completer();
            _cryptoListBloc.add(LoadCryptoList(completer: completer));
            return completer.future;
          },
          child: BlocBuilder<CryptoListBloc, CryptoListState>(
            bloc: _cryptoListBloc,
            builder: (context, state) {
              if (state is CryptoListLoaded) {
                return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    separatorBuilder: (context, index) => const Divider(
                          thickness: 0.3,
                        ),
                    itemCount: state.coinsList.length,
                    itemBuilder: (context, i) {
                      final coin = state.coinsList[i];
                      return CryptoCoinTile(coin: coin);
                    });
              }
              if (state is CryptoListLoadingFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Something went wrong",style: theme.textTheme.titleMedium),
                      const SizedBox(height: 10, width: 1),
                      Text("Please try again",style: theme.textTheme.labelSmall),
                      const SizedBox(height: 30, width: 1),
                      OutlinedButton(
                          onPressed: () {
                            _cryptoListBloc.add(LoadCryptoList());
                          },
                          child: const Text("Refresh"))
                    ],
                  ),
                );
              }
              if (state is CryptoListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else{
                return const FlutterLogo();
              }
            },
          ),
        ));
  }
}
